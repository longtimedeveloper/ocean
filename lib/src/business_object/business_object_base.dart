import '../src.dart';

abstract class BusinessObjectBase {
  BusinessObjectBase();

  /// Provides, activeRuleSet
  static const String activeRuleSetPropertyName = 'activeRuleSet';

  String? Function(String, dynamic)? _processExternalValidation;
  void Function(String, dynamic)? _onPropertyChangedCallback;

  String _activeRuleSet = ValidationConstants.insert;
  final BrokenValidationRules _brokenValidationRules = BrokenValidationRules();
  bool _isDirty = false;
  ProcessStringFormatRules _processStringFormatRules = ProcessStringFormatRules.yes;

  String get activeRuleSet {
    return _activeRuleSet;
  }

  Type get businessObjectRuntimeType {
    return runtimeType;
  }

  bool get isDirty {
    return _isDirty;
  }

  bool get isNotDirty {
    return !_isDirty;
  }

  bool get isNotValid {
    return !isValid;
  }

  bool get isValid {
    return _brokenValidationRules.hasNoErrors;
  }

  Function(bool)? _isValidCallback;

  set activeRuleSet(String value) {
    if (value.contains(StringCharacterConstants.pipeSymbol)) {
      throw OceanException(MessageConstants.activeRuleSetCanNotContainPipeSymobls);
    }
    _activeRuleSet = value;
  }

  /// This method is intended to be used internally within Ocean only.
  /// User's of Ocean shouldn't use this.
  /// For external validation use setProcessExternalValidation to add and remove an external callback.
  void addExternalValidationRuleBrokenRule(String propertyName, String ruleTypeName, String errorMessage) {
    var brokenRulesForProperty = _brokenValidationRules.getBrokenRulesForProperty(propertyName);
    if (brokenRulesForProperty.any((brokenRule) => brokenRule.ruleTypeName == ruleTypeName)) {
      return;
    }
    final brokenRule = BrokenRule(ruleTypeName, propertyName, errorMessage);
    final validateResult = ValidateResult(brokenRule);
    _brokenValidationRules.add(
      validateResult.brokenRule!.ruleTypeName,
      validateResult.brokenRule!.propertyName,
      validateResult.brokenRule!.errorMessage,
    );
    _onIsValidChanged();
  }

  void beginUIEditingMode() {
    _processStringFormatRules = ProcessStringFormatRules.no;
  }

  String? checkAllRules() {
    var currentIsValid = isValid;
    _brokenValidationRules.clear();

    var validationRulesManager = SharedValidationRulesManager.instance.getManager(runtimeType);
    var entityState = toJson();
    if (validationRulesManager.hasRules) {
      for (var entry in validationRulesManager.getRulesForEntity().entries) {
        for (var rule in entry.value.rulesList) {
          dynamic optionalValue;
          if (rule.optionalDataRequest != null) {
            optionalValue = getPropertyValue(rule.optionalDataRequest!.propertyName);
          }

          dynamic value = entityState[rule.propertyName]!;
          var validateResult = rule.validate(value, activeRuleSet, optionalValue: optionalValue);
          if (validateResult.isNotValid) {
            _brokenValidationRules.add(validateResult.brokenRule!.ruleTypeName, validateResult.brokenRule!.propertyName,
                validateResult.brokenRule!.errorMessage);
          }
          _checkExternalValidationRule(rule.propertyName, value);
        }
      }
    }
    if (currentIsValid != isValid) {
      _onIsValidChanged();
    }
    return getEntityErrors();
  }

  String? checkAllRulesForProperty(String propertyName, dynamic value) {
    if (propertyName.isEmpty) {
      throw OceanException(
          MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.propertyName));
    }
    var currentIsValid = isValid;
    _brokenValidationRules.remove(propertyName);

    var validationRulesManager = SharedValidationRulesManager.instance.getManager(runtimeType);

    if (validationRulesManager.hasRulesForProperty(propertyName)) {
      for (var rule in validationRulesManager.getRulesForProperty(propertyName).rulesList) {
        dynamic optionalValue;
        if (rule.optionalDataRequest != null) {
          optionalValue = getPropertyValue(rule.optionalDataRequest!.propertyName);
        }
        var validateResult = rule.validate(value, activeRuleSet, optionalValue: optionalValue);
        if (validateResult.isNotValid) {
          _brokenValidationRules.add(validateResult.brokenRule!.ruleTypeName, validateResult.brokenRule!.propertyName,
              validateResult.brokenRule!.errorMessage);
        }
      }
    }

    _checkExternalValidationRule(propertyName, value);

    final errorsText = getPropertyErrors(propertyName);

    if (currentIsValid != isValid) {
      _onIsValidChanged();
    }
    return errorsText;
  }

  void endUIEditingModel() {
    _processStringFormatRules = ProcessStringFormatRules.yes;
  }

  String? getEntityErrors() {
    if (_brokenValidationRules.hasErrors) {
      var buffer = StringBuffer();
      var previousPropertyName = StringCharacterConstants.stringEmpty;
      for (var brokenRule in _brokenValidationRules.getBrokenRules()) {
        if (previousPropertyName.isNotEmpty && brokenRule.propertyName != previousPropertyName) {
          previousPropertyName = brokenRule.propertyName;
          buffer.writeln(StringCharacterConstants.stringEmpty);
        } else if (previousPropertyName.isEmpty) {
          previousPropertyName = brokenRule.propertyName;
        }
        buffer.write(brokenRule.errorMessage + StringCharacterConstants.doubleSpace);
      }
      return buffer.toString().trimRight();
    }
    return null;
  }

  String? getPropertyErrors(String propertyName) {
    if (_brokenValidationRules.hasErrors) {
      var buffer = StringBuffer();
      for (var brokenRule in _brokenValidationRules.getBrokenRulesForProperty(propertyName)) {
        buffer.write(brokenRule.errorMessage + StringCharacterConstants.doubleSpace);
      }
      if (buffer.isNotEmpty) {
        return buffer.toString().trimRight();
      }
    }
    return null;
  }

  /// Gets the value of a property on this instance.
  ///
  /// Throws OceanArgumentException if the property name is not found on this instance.
  dynamic getPropertyValue(String propertyName) {
    Map<String, dynamic> currentState = toJson();
    if (currentState.containsKey(propertyName)) {
      return currentState[propertyName];
    }
    throw OceanArgumentException(FieldNameConstants.propertyName, MessageConstants.propertyNotFoundOnTypeFormat);
  }

  void removeExternalValidationRuleBrokenRule(String propertyName, String ruleTypeName) {
    _brokenValidationRules.removeByRuleTypeName(ruleTypeName, propertyName);
    _onIsValidChanged();
  }

  void resetAfterSaving() {
    _isDirty = false;
  }

  /// supply a void callback function to be notified when this entity's isValid property changes
  void setIsValidCallback(Function(bool)? isValidCallback) {
    _isValidCallback = isValidCallback;
  }

  // Invoked on all property changes.
  void setOnPropertyChangedCallback(void Function(String, dynamic)? onPropertyChanged) {
    _onPropertyChangedCallback = onPropertyChanged;
  }

  /// To added an an additional and external validation rule for one or more properties
  /// supply a callback function to be called when this property is being validated.
  void setProcessExternalValidation(String? Function(String, dynamic)? processExternalValidation) {
    _processExternalValidation = processExternalValidation;
  }

  /// runs all validation rules and returns newValue with approprite string format rules applied.
  dynamic setPropertyValue(String propertyName, dynamic currentValue, dynamic newValue) {
    if (propertyName.isEmpty) {
      throw OceanException(
          MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.propertyName));
    }
    if (currentValue == null && newValue == null) {
      return null;
    }
    if (newValue == null) {
      _isDirty = true;
    }
    if (currentValue != newValue) {
      _isDirty = true;
    }

    dynamic workingValue = newValue;

    if (_processStringFormatRules == ProcessStringFormatRules.yes && workingValue != null && workingValue is String) {
      workingValue = _formatPropertyValueUsingStringFormatRule(runtimeType, propertyName, workingValue);
    }

    checkAllRulesForProperty(propertyName, workingValue);
    _onPropertyChanged(propertyName, newValue);
    return workingValue;
  }

  Map<String, dynamic> toJson();

  void _checkExternalValidationRule(String propertyName, dynamic value) {
    if (_processExternalValidation != null) {
      final externalErrorMessage = _processExternalValidation!(propertyName, value);
      if (externalErrorMessage != null) {
        _brokenValidationRules.add("ExternalValidationRule", propertyName, externalErrorMessage);
      }
    }
  }

  String _formatPropertyValueUsingStringFormatRule(Type type, String propertyName, String propertyValue) {
    propertyValue = propertyValue.trim();
    if (propertyValue.isEmpty) {
      return StringCharacterConstants.stringEmpty;
    }

    var resultValue = propertyValue;
    var stringFormatRulesManager = SharedStringFormatRulesManager.instance.getManager(type);

    if (stringFormatRulesManager.hasRules) {
      var stringFormatRule = stringFormatRulesManager.getRuleForProperty(propertyName);
      if (stringFormatRule != null) {
        resultValue = FormatText.instance.applyStringFormat(stringFormatRule, resultValue);
      }
    }

    return resultValue;
  }

  void _onIsValidChanged() {
    if (_isValidCallback != null) {
      // this wrapper code, ensures that when this callback is invoked, it won't interrupt any build cycle currently in progress.
      Future.delayed(Duration.zero, () async {
        _isValidCallback!(isValid);
      });
    }
  }

  void _onPropertyChanged(String propertyName, dynamic newValue) {
    if (_onPropertyChangedCallback != null) {
      // this wrapper code, ensures that when this callback is invoked, it won't interrupt any build cycle currently in progress.
      Future.delayed(Duration.zero, () async {
        _onPropertyChangedCallback!.call(propertyName, newValue);
      });
    }
  }
}

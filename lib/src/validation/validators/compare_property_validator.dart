import '../../src.dart';

/// Validates two properties based on the [ComparisionType] to ensure the described rules are followed.
class ComparePropertyValidator extends ValidatorBase with CompareValuesMixin {
  /// Constructor for [ComparePropertyValidator].
  /// An [OptionalDataRequest] is automatically created for this rule for the [compareToPropertyName].  This is required for cross-validation of [BusinessObjectBase] properties.
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [compareToPropertyName] is a required field, and is the name of property to compare against.
  ///
  /// [comparisionType] is a required field, and is the [ComparisionType] rule for comparing the values.
  ///
  /// [requiredEntry] is optional, defaults to [RequiredEntry.yes].
  /// When [requiredEntry] is [RequiredEntry.no], if the value is empty, the validation will pass.
  /// When [requiredEntry] is [RequiredEntry.yes], if the value is empty or null, the validation will fail.
  ///
  /// [ruleSet] is optional, defauls to an empty string.
  /// If the [ruleSet] is not specified, this validation rule will always be checked.
  /// If the [ruleSet] is specified, this rule will only be checked if it is contained in the [BusinessObjectBase.activeRuleSet].
  /// If this rule applies to more than one [ruleSet], then enter each [ruleSet] name separated by the pipe symbol.  Example:  [ruleSet] = "Insert|Update|Delete"
  ///
  /// [friendlyName] is optional, defaults to an empty string.
  /// When supplied, will be used in place of the [propertyName] in validation error messages.
  ///
  /// [additionalMessage] is optional, defaults to an empty string.
  /// When supplied, [additionalMessage] is appended to the boken rule message in the [BusinessObjectBase.createFailedValidationMessage] method.
  ///
  /// [overrideErrorMessage] is optional, defaults to an empty string.
  /// When supplied, [overrideErrorMessage] replaces the broken rule message in the  [BusinessObjectBase.createFailedValidationMessage] method.
  ///
  /// [allowNullValue] is optional, defaults to [AllowNullValue.no].
  /// When [allowNullValue] is [AllowNullValue.no], if the value is null, the validation will fail.
  /// When [allowNullValue] is [AllowNullValue.yes], if the value is null, the validation will always pass.
  ///
  /// Throws [OceanArgumentException] if the propertyName is empty string.
  /// Throws [OceanArgumentException] if the compareToPropertyName is empty string.
  /// Throws [OceanArgumentException] if the propertyName and compareToPropertyName are equal.
  ComparePropertyValidator(
    String propertyName,
    this.compareToPropertyName,
    this.comparisionType, {
    String ruleSet = OceanStringCharacterConstants.stringEmpty,
    String friendlyName = OceanStringCharacterConstants.stringEmpty,
    String additionalMessage = OceanStringCharacterConstants.stringEmpty,
    String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
    AllowMultiple allowMultiple = AllowMultiple.no,
    this.compareToPropertyFriendlyName = OceanStringCharacterConstants.stringEmpty,
  }) : super(
          propertyName,
          ruleSet: ruleSet,
          friendlyName: friendlyName,
          additionalMessage: additionalMessage,
          overrideErrorMessage: overrideErrorMessage,
          allowMultiple: allowMultiple,
          allowNullValue: AllowNullValue.yes,
          requiredEntry: RequiredEntry.no,
          optionalDataRequest: OptionalDataRequest.propertyValue(compareToPropertyName),
        ) {
    if (compareToPropertyName.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.compareToPropertyName,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.compareToPropertyName),
      );
    }
    if (propertyName == compareToPropertyName) {
      throw OceanArgumentException(
        FieldNameConstants.propertyName,
        MessageConstants.mustNotBeEqualToFormat
            .formatString(FieldNameConstants.propertyName, FieldNameConstants.compareToPropertyName),
      );
    }
  }

  final String compareToPropertyFriendlyName;
  final String compareToPropertyName;
  final ComparisionType comparisionType;

  @override
  ValidateResult validate(value, businessObjectActiveRuleSet, {optionalValue}) {
    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.businessObjectActiveRuleSet,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.businessObjectActiveRuleSet),
      );
    }

    if (super.skipValidation(businessObjectActiveRuleSet)) {
      return ValidateResult.success();
    }

    final displayName = super.resolvedDisplayName();
    final compareToPropertyDisplayName = resolvedCompareToPropertyDisplayName();

    return compare(
      comparisionType,
      displayName,
      value,
      compareToPropertyDisplayName,
      optionalValue,
      super.createFailedValidateResult,
    );
  }

  String resolvedCompareToPropertyDisplayName() {
    if (compareToPropertyFriendlyName.isNotEmpty) {
      return compareToPropertyFriendlyName;
    }
    return compareToPropertyName.toTitleCase();
  }
}

import '../../src.dart';

/// Validates the entered value against these string length properties.
class StringLengthValidator extends ValidatorBase {
  /// Constructor for [StringLengthValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [minimumLength] is a required field, and is the minimum length for the value.
  ///
  /// [maximumLength] is a required field, and is the maximum length for the value.
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

  StringLengthValidator(
    String propertyName,
    int minimumLength,
    int maximumLength, {
    String ruleSet = OceanStringCharacterConstants.stringEmpty,
    String friendlyName = OceanStringCharacterConstants.stringEmpty,
    String additionalMessage = OceanStringCharacterConstants.stringEmpty,
    String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
    AllowNullValue allowNullValue = AllowNullValue.no,
    AllowMultiple allowMultiple = AllowMultiple.no,
  }) : super(
          propertyName,
          ruleSet: ruleSet,
          friendlyName: friendlyName,
          additionalMessage: additionalMessage,
          overrideErrorMessage: overrideErrorMessage,
          allowMultiple: allowMultiple,
          allowNullValue: allowNullValue,
          requiredEntry: RequiredEntry.no, // required entry is not used in this validator since min/max length handle this.
        ) {
    if (minimumLength < OceanNumericConstants.zero) {
      throw OceanArgumentException(FieldNameConstants.minimumLength, MessageConstants.mustBeGreaterThanZero);
    }
    if (maximumLength < minimumLength) {
      throw OceanArgumentException(
        FieldNameConstants.minimumLength,
        MessageConstants.mustBeGreterThanOrEqualToFormat.formatString(FieldNameConstants.minimumLength),
      );
    }
    _minimumLength = minimumLength;
    _maximumLength = maximumLength;
  }

  StringLengthValidator.maximumOnly(
    String propertyName,
    int maximumLength, {
    String ruleSet = OceanStringCharacterConstants.stringEmpty,
    String friendlyName = OceanStringCharacterConstants.stringEmpty,
    String additionalMessage = OceanStringCharacterConstants.stringEmpty,
    String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
    AllowNullValue allowNullValue = AllowNullValue.no,
  }) : super(
          propertyName,
          ruleSet: ruleSet,
          friendlyName: friendlyName,
          additionalMessage: additionalMessage,
          overrideErrorMessage: overrideErrorMessage,
          allowMultiple: AllowMultiple.no,
        ) {
    if (maximumLength < OceanNumericConstants.one) {
      throw OceanArgumentException(FieldNameConstants.maximumLength, MessageConstants.mustBeGreaterThanZero);
    }
    _minimumLength = OceanNumericConstants.minusOne;
    _maximumLength = maximumLength;
  }

  late final int _maximumLength;
  late final int _minimumLength;

  @override
  ValidateResult validate(dynamic value, String businessObjectActiveRuleSet, {dynamic optionalValue}) {
    if (value != null && value is! String) {
      throw OceanArgumentException(
        FieldNameConstants.value,
        MessageConstants.mustBeAStringTypeFormat.formatString(FieldNameConstants.value, value.runtimeType),
      );
    }

    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.businessObjectActiveRuleSet,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.businessObjectActiveRuleSet),
      );
    }

    if (super.skipValidation(businessObjectActiveRuleSet)) {
      return ValidateResult.success();
    }

    if (allowNullValue == AllowNullValue.yes && value == null) {
      return ValidateResult.success();
    }

    final displayName = super.resolvedDisplayName();

    if ((allowNullValue == AllowNullValue.no) && value == null) {
      return super.createFailedValidateResult(MessageConstants.nullValueNotAllowedFormat.formatString(displayName));
    }

    final targetValue = value.toString().trim();

    if (_minimumLength > OceanNumericConstants.zero && targetValue.length < _minimumLength) {
      return super
          .createFailedValidateResult(MessageConstants.isShorterThanFormat.formatString(displayName, _minimumLength));
    }

    if (targetValue.length > _maximumLength) {
      return super.createFailedValidateResult(MessageConstants.isLongerThanFormat.formatString(displayName, _maximumLength));
    }

    return ValidateResult.success();
  }
}

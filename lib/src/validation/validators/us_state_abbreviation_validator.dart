import '../../src.dart';

/// Validates the value against valid US State abbrviations.
class USStateAbbreviationValidator extends ValidatorBase {
  /// Constructor for [USStateAbbreviationValidator].
  ///
  /// [propertyName] is required, and is the property this validator is associated with.
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
  USStateAbbreviationValidator(
    String propertyName, {
    RequiredEntry requiredEntry = RequiredEntry.yes,
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
          allowNullValue: allowNullValue,
          requiredEntry: requiredEntry,
        );

  @override
  ValidateResult validate(value, String businessObjectActiveRuleSet, {optionalValue}) {
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

    if ((allowNullValue == AllowNullValue.no || requiredEntry == RequiredEntry.yes) && value == null) {
      return super.createFailedValidateResult(MessageConstants.nullValueNotAllowedFormat.formatString(displayName));
    }

    final targetValue = value.toString().trim();

    if (requiredEntry == RequiredEntry.no && targetValue.isEmpty) {
      return ValidateResult.success();
    }

    if (requiredEntry == RequiredEntry.yes && targetValue.isEmpty) {
      return super.createFailedValidateResult(MessageConstants.isRequiredFormat.formatString(displayName));
    }

    if (StateAbbreviationNameTool.instance.isValid(targetValue)) {
      return ValidateResult.success();
    }

    return super.createFailedValidateResult(
        MessageConstants.stateAbbreviationIsNotValidFormat.formatString(displayName, targetValue));
  }
}

import '../../src.dart';

/// Validates the value against the [compareToValue] based on the [comparisionType].
class CompareValueValidator extends ValidatorBase with CompareValuesMixin {
  /// Constructor for [CompareValueValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [compareToValue] is a required field, and is the value to compare against.
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
  CompareValueValidator(
    String propertyName,
    this.compareToValue,
    this.comparisionType, {
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

  final Comparable compareToValue;
  final ComparisionType comparisionType;

  @override
  ValidateResult validate(dynamic value, String businessObjectActiveRuleSet, {dynamic optionalValue}) {
    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.businessObjectActiveRuleSet,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(
          FieldNameConstants.businessObjectActiveRuleSet,
        ),
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

    if (value.runtimeType != compareToValue.runtimeType) {
      return super.createFailedValidateResult(
        MessageConstants.mustBeTheSameTypeFormat.formatString(
          displayName,
          value.runtimeType.toString(),
          compareToValue.runtimeType.toString(),
        ),
      );
    }

    return compare(
      comparisionType,
      displayName,
      value,
      compareToValue.toString(),
      compareToValue,
      super.createFailedValidateResult,
    );
  }
}

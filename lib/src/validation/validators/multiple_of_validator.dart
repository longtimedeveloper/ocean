import '../../src.dart';

/// Validates that the value is a multiple of [multipleOf].
class MultipleOfValidator extends ValidatorBase {
  /// Constructor for [CompareValueValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [multipleOf] is a required field, and is the value that will be used as the divisor to determine if the property value is a multiple of this value.
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
  MultipleOfValidator(
    String propertyName,
    this.multipleOf, {
    RequiredEntry requiredEntry = RequiredEntry.yes,
    String ruleSet = StringCharacterConstants.stringEmpty,
    String friendlyName = StringCharacterConstants.stringEmpty,
    String additionalMessage = StringCharacterConstants.stringEmpty,
    String overrideErrorMessage = StringCharacterConstants.stringEmpty,
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
        ) {
    if (multipleOf < NumericConstants.one) {
      throw OceanArgumentException(FieldNameConstants.multipleOf, MessageConstants.mustBeGreaterThanZero);
    }
  }

  final int multipleOf;

  @override
  ValidateResult validate(value, businessObjectActiveRuleSet, {optionalValue}) {
    if (value != null && value is! int) {
      throw OceanArgumentException(
        FieldNameConstants.value,
        MessageConstants.mustBeAnIntTypeFormat.formatString(FieldNameConstants.value, value.runtimeType),
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

    final targetValue = int.parse(value.toString());

    if (targetValue % multipleOf == 0) {
      return ValidateResult.success();
    }

    return super.createFailedValidateResult(
      MessageConstants.valueIsNotDivisibleByFormat.formatString(displayName, targetValue, multipleOf),
    );
  }
}

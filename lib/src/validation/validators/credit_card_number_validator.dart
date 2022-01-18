import '../../src.dart';

/// Validates a credit card number.
class CreditCardNumberValidator extends ValidatorBase {
  /// Constructor for [CompareValueValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
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
  CreditCardNumberValidator(
    String propertyName, {
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
        );

  @override
  ValidateResult validate(value, businessObjectActiveRuleSet, {optionalValue}) {
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

    if (allowNullValue == AllowNullValue.yes && value == null) {
      return ValidateResult.success();
    }

    final displayName = super.resolvedDisplayName();

    if ((allowNullValue == AllowNullValue.no || requiredEntry == RequiredEntry.yes) && value == null) {
      return super.createFailedValidateResult(MessageConstants.nullValueNotAllowedFormat.formatString(displayName));
    }

    if (super.skipValidation(businessObjectActiveRuleSet)) {
      return ValidateResult.success();
    }

    final targetValue = value.toString().trim();

    if (requiredEntry == RequiredEntry.no && targetValue.isEmpty) {
      return ValidateResult.success();
    }

    if (requiredEntry == RequiredEntry.yes && targetValue.isEmpty) {
      return super.createFailedValidateResult(MessageConstants.isRequiredFormat.formatString(displayName));
    }

    if (!targetValue.isAllDigits()) {
      return super.createFailedValidateResult(
        MessageConstants.creditCardNumberIsNotAValidCreditCardNumberOnlyNumericInputIsAllowedFormat
            .formatString(displayName, targetValue),
      );
    }

    final creditCardNumberLength = targetValue.length;
    var cardArray = [for (var i = 0; i <= creditCardNumberLength + 1; i++) 0];

    for (var count = creditCardNumberLength - 1; count >= 1; count -= 2) {
      var elementValue = int.parse(targetValue.substring(count - 1, count)) * 2;
      cardArray[count] = elementValue;
    }

    int start = creditCardNumberLength % 2 == 0 ? 2 : 1;
    int calculatedValue = 0;

    for (var count = start; count <= creditCardNumberLength; count += 2) {
      calculatedValue += int.parse(targetValue.substring(count - 1, count));
      int arrValue = cardArray[count - 1];

      if (arrValue < 10) {
        calculatedValue += arrValue;
      } else {
        calculatedValue += int.parse(arrValue.toString().substring(0, 1)) +
            int.parse(
              arrValue.toString().substring(arrValue.toString().length - 1),
            );
      }
    }

    if (calculatedValue % 10 != 0) {
      return super.createFailedValidateResult(
        MessageConstants.creditCardNumberIsNotValidFormat.formatString(displayName, targetValue),
      );
    }

    return ValidateResult.success();
  }
}

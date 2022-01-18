class DebuggingConstants {
  static const bool showDebuggingInformation = false;
}

class MessageConstants {
  /// Provides, Active rule set can not contain any pipe symbols. This is normally caused when a validation constant is passed that is for multiple rule sets and not a single rule set that this property requires.
  static const String activeRuleSetCanNotContainPipeSymobls =
      'Active rule set can not contain any pipe symbols. This is normally caused when a validation constant is passed that is for multiple rule sets and not a single rule set that this property requires.';

  /// Provides, When specialCharacter equal SpecialCharacter.yes, allowedPasswordSpecialCharacters can not be empty.
  static const String allowedPasswordSpecialCharactersRequired =
      'When specialCharacter equal SpecialCharacter.yes, allowedPasswordSpecialCharacters can not be empty.';

  /// Provides, two placeholders for, {0} {1} is not a valid credit card number.  Only numeric input is allowed.
  static const String creditCardNumberIsNotAValidCreditCardNumberOnlyNumericInputIsAllowedFormat =
      '{0} {1} is not a valid credit card number.  Only numeric input is allowed.';

  /// Provides, two placeholders for, {0} {1} is not a valid credit card number.
  static const String creditCardNumberIsNotValidFormat = '{0} {1} is not a valid credit card number.';

  /// Provides, three placeholders for, {0} {1} did not match any of the acceptable values {2}.
  static const String didNotMatchAnyOfTheAcceptableValuesFormat = '{0} {1} did not match any of the acceptable values {2}.';

  /// Provides, Duplicate {0} key, key already added.
  static const String duplicateKeyAlreadyAddedFormat = 'Duplicate {0} key, key already added.';

  /// Provides, Duplicate dialog position {0}, has already added.
  static const String duplicateDialogPositionAlreadyAddedFormat = 'Duplicate dialog position {0}, has already added.';

  /// Provides, one placeholder for, Invalid StringCasing, must be a Phone casing value. Passed value was: {0}.
  static const String invalidStringCasingMustBeAPhoneCasingFormat =
      'Invalid StringCasing, must be a Phone casing value. Passed value was: {0}.';

  /// Provides, two placeholders for, {0} is longer than {1}.
  static const String isLongerThanFormat = '{0} is longer than {1}.';

  /// Provides, two placeholders for, {0} {1} is not a valid bank routing number. All bank routing numbers are 9 digits in length.
  static const String isNotAValidBankRoutingNumberAllBankRoutingNumbersAreNineDigitsInLengthFormat =
      '{0} {1} is not a valid bank routing number. All bank routing numbers are 9 digits in length.';

  /// Provides, two placeholders for, {0} {1} is not a valid bank routing number. The first digit must be a 0 or a 1.
  static const String isNotAValidBankRoutingNumberAllBankRoutingNumbersFirstDigitMustBeZeorOrOneFormat =
      '{0} {1} is not a valid bank routing number. The first digit must be a 0 or a 1.';

  /// Provides, two placeholders for, {0} {1} is not a valid bank routing number.
  static const String isNotAValidBankRoutingNumberFormat = '{0} {1} is not a valid bank routing number.';

  /// Provides, one placeholder for, {0} is required.
  static const String isRequiredFormat = '{0} is required.';

  /// Provides, one placeholder for, {0} is required to be checked.
  static const String isRequiredToBeCheckedFormat = '{0} is required to be checked.';

  /// Provides, one placeholder for, {0} is required to have at least one element.
  static const String isRequiredToHaveAtLeastOneElementFormat = '{0} is required to have at least one element.';

  /// Provides, two placeholders for, {0} is shorter than {1}.
  static const String isShorterThanFormat = '{0} is shorter than {1}.';

  /// Provides, {0} key not found.
  static const String keyNotFoundFormat = '{0} key not found.';

  /// Provides, Length must be one.
  static const String lengthMustBeOne = 'Length must be one.';

  /// Provides, one placeholder for, The {0} argument was an empty map, but is required.
  static const String mapArgumentIsRequiredButEmptyFormat = 'The {0} argument was an empty map, but is required.';

  /// Provides, two placeholders for, Multiple PropertyMetadata not allowed for string format {0}, property name {1}.
  static const String multiplePropertyMetadataNotAllowedFormat =
      'Multiple PropertyMetadata not allowed for string format {0}, property name {1}.';

  /// Provides, two placeholders for, Multiple rules not allowed for string format {0}, property name {1}.
  static const String multipleStringFormateRulesNotAllowedFormat =
      'Multiple rules not allowed for string format {0}, property name {1}.';

  /// Provides, two placeholders for, Multiple rules not allowed for validator runtime type {0}, property name {1}.
  static const String multipleValidationRulesNotAllowedFormat =
      'Multiple rules not allowed for string format {0}, property name {1}.';

  /// Provides, one placeholder for, {0} must be a bool type but was a {1} type.
  static const String mustBeABoolTypeFormat = '{0} must be a bool type but was a {1} type.';

  /// Provides, one placeholder for, {0} must be a String type but was a {1} type.
  static const String mustBeAStringTypeFormat = '{0} must be a String type but was a {1} type.';

  /// Provides, one placeholder for, {0} must be an int type but was a {1} type.
  static const String mustBeAnIntTypeFormat = '{0} must be an int type but was a {1} type.';

  /// Provides, two placeholders for, {0} must be equal to {1}.
  static const String mustBeEqualToFormat = '{0} must be equal to {1}.';

  /// Provides, two placeholders for, {0} must be greater than to {1}.
  static const String mustBeGreaterThanFormat = '{0} must be greater than to {1}.';

  /// Provides, two placeholders for, {0} must be greater than or equal to {1}.
  static const String mustBeGreaterThanOrEqualToFormat = '{0} must be greater than or equal to {1}.';

  /// Provides, Must be greater than zero.
  static const String mustBeGreaterThanZero = 'Must be greater than zero.';

  /// Provides, one placeholder for, Must be greater than or equal to {0}.
  static const String mustBeGreterThanOrEqualToFormat = 'Must be greater than or equal to {0}.';

  /// Provides, two placeholders for, {0} must be less than to {1}.
  static const String mustBeLessThanFormat = '{0} must be less than to {1}.';

  /// Provides, two placeholders for, {0} must be greater than or equal to {1}.
  static const String mustBeLessThanOrEqualToFormat = '{0} must be less than or equal to {1}.';

  /// Provides, two placeholeders for, {0} and {1} must be the same length.
  static const String mustBeTheSameLengthFormat = '{0} and {1} must be the same length.';

  /// Provides, three placeholders for, {0}, type {1}, must be the same type as the compare value type {2}.
  static const String mustBeTheSameTypeFormat = '{0}, type {1}, must be the same type as the compare value type {2}.';

  /// Provides, two placeholders for, {0} and {1} must match.
  static const String mustMatchFormat = '{0} and {1} must match.';

  /// Provides, two placeholders for, {0} must not be equal to {1}.
  static const String mustNotBeEqualToFormat = '{0} must not be equal to {1}.';

  /// Provides, one placeholder for, {0} null value is not allowed.
  static const String nullValueNotAllowedFormat = '{0} null value is not allowed.';

  /// Provides, one placeholder for, The {0} argument was null but is required.
  static const String nullValueNotAllowedWhenValueIsRequiredFormat = 'The {0} argument was null but is required.';

  /// Provides, two placeholders for, {0} has these invalid special characters: {1},
  static const String passwordHasTheseInvalidSpecialCharactersFormat = '{0} has these invalid special characters: {1}';

  /// Provides, two placeholders for, {0} has this invalid special character: {1},
  static const String passwordHasThisInvalidSpecialCharactersFormat = '{0} has this invalid special character: {1}';

  /// Provides, one placeholder for, {0} must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.
  static const String passwordMustNotHaveRepeatingPatternsFormat =
      '{0} must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.';

  /// Provides, one digit,
  static const String passwordOneDigit = 'one digit, ';

  /// Provides, one lower case letter,
  static const String passwordOneLowerCaseLetter = 'one lower case letter, ';

  /// Provides, one placeholder for, one of these special characters {0},
  static const String passwordOneSpecialCharacterFormat = 'one of these special characters {0}, ';

  /// Provides, at one upper case letter,
  static const String passwordOneUpperCaseLetter = 'one upper case letter, ';

  /// Provides, two placeholders for, Recommended minimum length {0}.  Score {1} out of 100.
  static const String passwordScoreMessageFormat = 'Recommended minimum length {0}.  Score {1} out of 100.';

  /// Provides, Passwords do not match.
  static const String passwordsDoNotMatchErrorMessage = 'Passwords do not match';

  /// Provides, one placeholder for, Property metadata not found for property {0}.
  static const String propertyMetadataNotFoundForPropertyFormat = 'Property metadata not found for property {0}.';

  /// Provides, two placeholders for, Property {0} not found on type {1}.
  static const String propertyNotFoundOnTypeFormat = 'Property {0} not found on type {1}.';

  /// Provides, one placeholder for, {0} did not match the required email pattern.
  static const String regularExpressionDidNotMatchTheRequiredEmailPatternFormat =
      '{0} did not match the required email pattern.';

  /// Provides, one placeholder for, {0} did not match the required IP address pattern.
  static const String regularExpressionDidNotMatchTheRequiredIPAddressPatternFormat =
      '{0} did not match the required IP address pattern.';

  /// Provides, two placeholders for, {0} did not match the required {1} pattern.
  static const String regularExpressionDidNotMatchTheRequiredPatternFormat = '{0} did not match the required {1} pattern.';

  /// Provides, one placeholder for, {0} did not match the required SSN pattern.
  static const String regularExpressionDidNotMatchTheRequiredSSNPatternFormat =
      '{0} did not match the required SSN pattern.';

  /// Provides, one placeholder for, {0} did not match the required URL pattern.
  static const String regularExpressionDidNotMatchTheRequiredURLPatternFormat =
      '{0} did not match the required URL pattern.';

  /// Provides, two placeholders for, {0} did not match the required US phone number pattern.
  static const String regularExpressionDidNotMatchTheRequiredUSPhoneNumberPatternFormat =
      '{0} did not match the required US phone number pattern.';

  /// Provides, one placeholder for, {0} did not match the required zip code pattern.
  static const String regularExpressionDidNotMatchTheRequiredZipCodePatternFormat =
      '{0} did not match the required zip code pattern.';

  /// Provides, one placeholder for, Invalid custom regular expression pattern.
  static const String regularExpressionInvalidCustomRegularExpressionPattern = 'Invalid custom regular expression pattern.';

  /// Provides, one placeholder for, Invalid custom regular expression pattern.
  static const String dialogCompleterIsNull =
      'Dialog Completer is null. DialogComplete can only be called once from a dialog.';

  /// Provides, SharedStringCasingChecks has not been initialized.  SharedStringCasingChecks.loadDefaultChecks or SharedStringCasingChecks.loadChecks must be called first.
  static const String sharedStringCasingChecksMustBeLoaded =
      'SharedStringCasingChecks has not been initialized. SharedStringCasingChecks.loadDefaultChecks or SharedStringCasingChecks.loadChecks must be called first.';

  /// Provides, two placeholders, {0} '{1}' state abbreviation is not valid.
  static const String stateAbbreviationIsNotValidFormat = '{0} state abbreviation ({1}) is not valid.';

  /// Provides, one placeholder for, State not found for state abbreviation: {0}.
  static const String stateNotFoundForStateAppreviationFormat = 'State not found for state abbreviation: {0}.';

  /// Provides, one placeholder for, The {0} argument was empty but is required.
  static const String stringArgumentIsRequiredButEmptyFormat = 'The {0} argument was empty but is required.';

  /// Provides, three placeholders for, {0} value {1} is not divisible by {2}.
  static const String valueIsNotDivisibleByFormat = '{0} value {1} is not divisible by {2}.';
}

class StringConstants {
  /// Provides, Dialog Builder
  static const String dialogBuilder = 'Dialog Builder';

  /// Provides, SnackBar Builder
  static const String snackBarBuilder = 'SnackBar Builder';
}

class FieldNameConstants {
  /// Provides, allowedPasswordSpecialCharacters
  static const String allowedPasswordSpecialCharacters = 'allowedPasswordSpecialCharacters';

  /// Provides, businessObjectActiveRuleSet
  static const String businessObjectActiveRuleSet = 'businessObjectActiveRuleSet';

  /// Provides, compareToPropertyName
  static const String compareToPropertyName = 'compareToPropertyName';

  /// Provides, comparisionType
  static const String comparisionType = 'comparisionType';

  /// Provides, data
  static const String data = 'data';

  /// Provides, dialogButtons
  static const String dialogButtons = 'dialogButtons';

  /// Provides, key
  static const String key = 'key';

  /// Provides, lookFor
  static const String lookFor = 'lookFor';

  /// Provides, upperRangeBoundaryType
  static const String lowerRangeBoundaryType = 'lowerRangeBoundaryType';

  /// Provides, maximumLength
  static const String maximumLength = 'maximumLength';

  /// Provides, message
  static const String message = 'message';

  /// Provides, minimumLength
  static const String minimumLength = 'minimumLength';

  /// Provides, multipleOf
  static const String multipleOf = 'multipleOf';

  /// Provides, propertyName
  static const String propertyName = 'propertyName';

  /// Provides, regularExpressionPatternType
  static const String regularExpressionPatternType = 'regularExpressionPatternType';

  /// Provides, replaceWith
  static const String replaceWith = 'replaceWith';

  /// Provides, stateAbbreviation
  static const String stateAbbreviation = 'stateAbbreviation';

  /// Provides, StringCasingMethod
  static const String stringCasingMethod = 'StringCasingMethod';

  /// Provides, upperRangeBoundaryType
  static const String upperRangeBoundaryType = 'upperRangeBoundaryType';

  /// Provides, value
  static const String value = 'value';
}

import '../../src.dart';

/// CRITICAL SECURITY ALERT:  NEVER use this validator on a public facing password field, such as a login screen password field.
/// Doing this exposes your internal password requirements. DO NOT DO THIS!
/// The only exception is a new user page where you get the password as part of registering a new user in the system.
class PasswordValidator extends ValidatorBase {
  /// Constructor for [CompareValueValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [minimumLength] is a required field, and is the minimum length for the password.
  ///
  /// [maximumLength] is a required field, and is the maximum length for the password.
  ///
  /// [allowedPasswordSpecialCharacters] is a required field, and is the developer defined allowed special characters for this property validator.
  ///
  /// [digitCharacter] is optional, defaults to [DigitCharacter.yes].  When yes, requires at least one digit must be in the password.
  ///
  /// [lowerCaseCharacter] is optional, defaults to [LowerCaseCharacter.yes].  When yes, requires at least one lowercase letter must be in the password.
  ///
  /// [upperCaseCharacter] is optional, defaults to [UpperCaseCharacter.yes].  When yes, requires at least one uppercase letter must be in the password.
  ///
  /// [specialCharacter] is optional, defaults to [SpecialCharacter.yes].  When yes, requires at least one special character must be in the password.
  ///
  /// [allowSequencesOrRepeatedCharacters] is optional, defaults to [AllowSequencesOrRepeatedCharacters.no]. When no, prevents uses from entering sequences in their passwords such as:  123 321 abc cba 111 zzz, etc.
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
  PasswordValidator(
    String propertyName,
    int minimumLength,
    int maximumLength,
    String allowedPasswordSpecialCharacters, {
    digitCharacter = DigitCharacter.yes,
    lowerCaseCharacter = LowerCaseCharacter.yes,
    upperCaseCharacter = UpperCaseCharacter.yes,
    specialCharacter = SpecialCharacter.yes,
    allowSequencesOrRepeatedCharacters = AllowSequencesOrRepeatedCharacters.no,
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
          requiredEntry: RequiredEntry.no, // required entry is not used in this validator since min/max length handle this.
        ) {
    if (specialCharacter == SpecialCharacter.yes && allowedPasswordSpecialCharacters.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.allowedPasswordSpecialCharacters,
        MessageConstants.allowedPasswordSpecialCharactersRequired,
      );
    }
    if (minimumLength < OceanNumericConstants.zero) {
      throw OceanArgumentException(
        FieldNameConstants.minimumLength,
        MessageConstants.mustBeGreaterThanZero,
      );
    }
    if (maximumLength < minimumLength) {
      throw OceanArgumentException(
        FieldNameConstants.minimumLength,
        MessageConstants.mustBeGreterThanOrEqualToFormat.formatString(FieldNameConstants.minimumLength),
      );
    }
    _minimumLength = minimumLength;
    _maximumLength = maximumLength;
    _digitCharacter = digitCharacter;
    _lowerCaseCharacter = lowerCaseCharacter;
    _upperCaseCharacter = upperCaseCharacter;
    _specialCharacter = specialCharacter;
    _allowedPasswordSpecialCharacters = allowedPasswordSpecialCharacters;
    _allowedPasswordSpecialCharactersList = <String>[];
    for (var i = 0; i < _allowedPasswordSpecialCharacters.length; i++) {
      _allowedPasswordSpecialCharactersList.add(_allowedPasswordSpecialCharacters[i]);
    }
    _allowSequencesOrRepeatedCharacters = allowSequencesOrRepeatedCharacters;
  }

  late final AllowSequencesOrRepeatedCharacters _allowSequencesOrRepeatedCharacters;
  late final String _allowedPasswordSpecialCharacters;
  late final List<String> _allowedPasswordSpecialCharactersList;
  late final DigitCharacter _digitCharacter;
  late final LowerCaseCharacter _lowerCaseCharacter;
  late final int _maximumLength;
  late final int _minimumLength;
  late final SpecialCharacter _specialCharacter;
  late final UpperCaseCharacter _upperCaseCharacter;

  @override
  ValidateResult validate(value, businessObjectActiveRuleSet, {optionalValue}) {
    if (value != null && value is! String) {
      throw OceanArgumentException(FieldNameConstants.value,
          MessageConstants.mustBeAStringTypeFormat.formatString(FieldNameConstants.value, value.runtimeType));
    }

    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
          FieldNameConstants.businessObjectActiveRuleSet,
          MessageConstants.stringArgumentIsRequiredButEmptyFormat
              .formatString(FieldNameConstants.businessObjectActiveRuleSet));
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

    final buffer = StringBuffer();

    if (_lowerCaseCharacter == LowerCaseCharacter.yes &&
        targetValue.countOfLowerCaseLetters() == OceanNumericConstants.zero) {
      buffer.write(MessageConstants.passwordOneLowerCaseLetter);
    }

    if (_upperCaseCharacter == UpperCaseCharacter.yes &&
        targetValue.countOfUpperCaseLetters() == OceanNumericConstants.zero) {
      buffer.write(MessageConstants.passwordOneUpperCaseLetter);
    }

    if (_digitCharacter == DigitCharacter.yes && targetValue.countOfDigits() == OceanNumericConstants.zero) {
      buffer.write(MessageConstants.passwordOneDigit);
    }

    if (_specialCharacter == SpecialCharacter.yes &&
        targetValue.countOfSpecialCharacters(_allowedPasswordSpecialCharactersList) == OceanNumericConstants.zero) {
      buffer.write(MessageConstants.passwordOneSpecialCharacterFormat.formatString(_allowedPasswordSpecialCharacters));
    }

    var invalidSpecialCharactersMessage = OceanStringCharacterConstants.stringEmpty;
    var invalidSpecialCharacters = _invalidSpecialCharacterCheck(value);
    if (invalidSpecialCharacters.isNotEmpty) {
      if (invalidSpecialCharacters.length == 1) {
        invalidSpecialCharactersMessage = MessageConstants.passwordHasThisInvalidSpecialCharactersFormat
            .formatString(displayName, invalidSpecialCharacters);
      } else {
        invalidSpecialCharactersMessage = MessageConstants.passwordHasTheseInvalidSpecialCharactersFormat
            .formatString(displayName, invalidSpecialCharacters);
      }
    }

    var repeatedCharactersMessage = OceanStringCharacterConstants.stringEmpty;
    if (_allowSequencesOrRepeatedCharacters == AllowSequencesOrRepeatedCharacters.no &&
        _hasThreeOrMoreConsecutiveNumbersOrLettersOrRepeatedNumbersOrLetters(targetValue)) {
      repeatedCharactersMessage = MessageConstants.passwordMustNotHaveRepeatingPatternsFormat.formatString(displayName);
    }

    var validationErrorMessage = OceanStringCharacterConstants.stringEmpty;
    if (buffer.isNotEmpty || invalidSpecialCharactersMessage.isNotEmpty || repeatedCharactersMessage.isNotEmpty) {
      if (buffer.isNotEmpty) {
        var errorMessage = buffer.toString();
        errorMessage = errorMessage.substring(0, errorMessage.length - 2);
        validationErrorMessage = "$displayName must have at least $errorMessage".trim();
      }

      if (invalidSpecialCharactersMessage.isNotEmpty) {
        if (validationErrorMessage.isNotEmpty) {
          validationErrorMessage += OceanStringCharacterConstants.newLineCharacter + invalidSpecialCharactersMessage.trim();
        } else {
          validationErrorMessage = invalidSpecialCharactersMessage.trim();
        }
      }

      if (repeatedCharactersMessage.isNotEmpty) {
        if (validationErrorMessage.isNotEmpty) {
          validationErrorMessage += OceanStringCharacterConstants.newLineCharacter + repeatedCharactersMessage.trim();
        } else {
          validationErrorMessage = repeatedCharactersMessage.trim();
        }
      }

      return super.createFailedValidateResult(validationErrorMessage);
    }

    return ValidateResult.success();
  }

  bool _hasThreeOrMoreConsecutiveNumbersOrLettersOrRepeatedNumbersOrLetters(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    bool trackgingDigits = false;
    bool trackingLetters = false;
    String found = '';

    for (var i = 0; i < value.length; i++) {
      var c = value[i];

      if (trackgingDigits == true && c.isSingleDigitCharacter()) {
        found += c;
        var foundLength = found.length;
        if (foundLength > 1) {
          var previousValue = int.parse(found[foundLength - 2]);
          var currentValue = int.parse(c);
          if (previousValue == currentValue + 1 || previousValue == currentValue - 1) {
            if (found.length == 3) {
              return true;
            }
            continue;
          } else {
            found = c;
          }
        } else {
          found = c;
          trackgingDigits = true;
        }
        continue;
      } else if (trackingLetters == true && c.isSingleLetterCharacter()) {
        found += c;
        var foundLength = found.length;
        if (foundLength > 1) {
          var previousValue = found[foundLength - 2].codeUnits[0];
          var currentValue = c.codeUnits[0];
          if (previousValue == currentValue + 1 || previousValue == currentValue - 1) {
            if (found.length == 3) {
              return true;
            }
            continue;
          } else {
            found = c;
          }
        } else {
          found = c;
          trackingLetters = true;
        }
        continue;
      }

      trackgingDigits = false;
      trackingLetters = false;
      found = '';

      if (c.isSingleDigitCharacter()) {
        found = c;
        trackgingDigits = true;
      } else if (c.isSingleLetterCharacter()) {
        found = c;
        trackingLetters = true;
      }
    }

    for (var i = 0; i < value.length; i++) {
      var c = value[i];
      var find = c + c + c;
      if (value.contains(find)) {
        return true;
      }
    }

    return false;
  }

  String _invalidSpecialCharacterCheck(String? value) {
    if (value == null || value.isEmpty) {
      return OceanStringCharacterConstants.stringEmpty;
    }
    var foundInvalidCharacters = OceanStringCharacterConstants.stringEmpty;
    for (var i = 0; i < value.length; i++) {
      var c = value[i];
      if (c.isSingleLetterCharacter() || c.isSingleDigitCharacter()) {
        continue;
      }
      if (!_allowedPasswordSpecialCharacters.contains(c)) {
        foundInvalidCharacters += c;
      }
    }

    return foundInvalidCharacters;
  }
}

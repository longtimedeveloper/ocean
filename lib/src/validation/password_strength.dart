import 'dart:math';
import '../src.dart';

// Learned a lot from this article https://www.omnicalculator.com/other/password-entropy
// Learned a lot from this article https://www.statology.org/normalize-data-between-0-and-100/

class PasswordStrength {
  static PasswordStrengthResult calculate(
    String password,
    String allowedSpecialCharacters,
    int goldStandardForPasswordLength,
    LowerCaseCharacter lowerCaseCharactersAllowed,
    UpperCaseCharacter upperCaseCharactersAllowed,
    DigitCharacter digitCharactersAllowed,
    SpecialCharacter specialCharactersAllowed,
  ) {
    if (password.trim().isEmpty) {
      return PasswordStrengthResult.unsafe();
    }

    List<String> allowedSpecialCharactersList = <String>[];
    for (var i = 0; i < allowedSpecialCharacters.length; i++) {
      allowedSpecialCharactersList.add(allowedSpecialCharacters[i]);
    }

    var passwordLength = password.length;
    var allowedSpecialCharactersLength = allowedSpecialCharacters.length;
    var countOfLowerCaseLetters = password.countOfLowerCaseLetters();
    var countOfUpperCaseLetters = password.countOfUpperCaseLetters();
    var countOfDigits = password.countOfDigits();
    var countOfSpecialCharacters = password.countOfSpecialCharacters(allowedSpecialCharactersList);

    var poolSize = _getPoolSize(
      countOfLowerCaseLetters,
      countOfUpperCaseLetters,
      countOfDigits,
      countOfSpecialCharacters,
      allowedSpecialCharacters,
    );
    var entropy = _calculateEntropy(passwordLength, poolSize);
    var maxEntropy = _calculateTheMaxEntropy(
      allowedSpecialCharactersLength,
      goldStandardForPasswordLength,
      lowerCaseCharactersAllowed,
      upperCaseCharactersAllowed,
      digitCharactersAllowed,
      specialCharactersAllowed,
    );
    var passwordStrength = _normalizeEntropyToResultBasedOnOneHundred(entropy, maxEntropy);
    var passwordSafetyLevel = _getPasswordSafetyLevel(passwordStrength);

    return PasswordStrengthResult(
      passwordStrength: passwordStrength,
      passwordSafetyLevel: passwordSafetyLevel,
      passwordLength: passwordLength,
      countOfLowerCaseLetters: countOfLowerCaseLetters,
      countOfUpperCaseLetters: countOfUpperCaseLetters,
      countOfDigits: countOfDigits,
      countOfSpecialCharacters: countOfSpecialCharacters,
      maximumNumberOfSpecialCharactersPossible: allowedSpecialCharactersLength,
    );
  }

  static int _calculateEntropy(int passwordLength, int poolSize) {
    return (passwordLength * log(poolSize) / log(2)).round();
  }

  static int _calculateTheMaxEntropy(
    int allowedSpecialCharactersLength,
    int goldStandardForPasswordLength,
    LowerCaseCharacter lowerCaseCharactersAllowed,
    UpperCaseCharacter upperCaseCharactersAllowed,
    DigitCharacter digitCharactersAllowed,
    SpecialCharacter specialCharactersAllowed,
  ) {
    // 62 is the number of lower and upper case letters + the number of digits  26 + 26 + 10;
    // allowedSpecialCharactersLength is the length of the possible special characters the developer is allowing to be used.  EX:  ')(&$' is a count of 4.

    var maximumSizeOfThePool = 0;
    if (lowerCaseCharactersAllowed == LowerCaseCharacter.yes) {
      maximumSizeOfThePool += 26;
    }
    if (upperCaseCharactersAllowed == UpperCaseCharacter.yes) {
      maximumSizeOfThePool += 26;
    }
    if (digitCharactersAllowed == DigitCharacter.yes) {
      maximumSizeOfThePool += 10;
    }
    if (specialCharactersAllowed == SpecialCharacter.yes) {
      maximumSizeOfThePool += allowedSpecialCharactersLength;
    }

    // goldStandardForPasswordLength really effects the normalized returned value.
    // If the value is 12, this pushes users to enter 12 characters.
    // The lower the number of characters in the user password, the lower this score will be.
    var maxEntropy = goldStandardForPasswordLength * log(maximumSizeOfThePool) / log(2);

    return maxEntropy.round();
  }

  static PasswordSafetyLevel _getPasswordSafetyLevel(int passwordStrength) {
    if (passwordStrength > 90) {
      return PasswordSafetyLevel.high;
    }
    if (passwordStrength > 75) {
      return PasswordSafetyLevel.medium;
    }
    if (passwordStrength > 60) {
      return PasswordSafetyLevel.low;
    }
    return PasswordSafetyLevel.unsafe;
  }

  static int _getPoolSize(
    int countOfLowerCaseLetters,
    int countOfUpperCaseLetters,
    int countOfDigits,
    int countOfSpecialCharacters,
    String allowedSpecialCharacters,
  ) {
    var poolSize = 0;
    if (countOfLowerCaseLetters > 0) {
      poolSize += 26;
    }
    if (countOfUpperCaseLetters > 0) {
      poolSize += 26;
    }
    if (countOfDigits > 0) {
      poolSize += 10;
    }
    if (countOfSpecialCharacters > 0) {
      poolSize += allowedSpecialCharacters.length;
    }

    return poolSize;
  }

  static int _normalizeEntropyToResultBasedOnOneHundred(
    int entropy,
    int maxEntropy,
  ) {
    var result = (entropy / maxEntropy * 100).round();
    if (result > 100) {
      result = 100;
    }
    return result;
  }
}

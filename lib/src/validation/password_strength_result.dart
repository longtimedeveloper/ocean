import 'package:ocean/src/validation/password_safety_level.dart';

class PasswordStrengthResult {
  PasswordStrengthResult({
    required this.passwordStrength,
    required this.passwordSafetyLevel,
    required this.passwordLength,
    required this.countOfLowerCaseLetters,
    required this.countOfUpperCaseLetters,
    required this.countOfDigits,
    required this.countOfSpecialCharacters,
    required this.maximumNumberOfSpecialCharactersPossible,
  });

  factory PasswordStrengthResult.unsafe() {
    return PasswordStrengthResult(
      passwordStrength: 0,
      passwordSafetyLevel: PasswordSafetyLevel.unsafe,
      passwordLength: 0,
      countOfLowerCaseLetters: 0,
      countOfUpperCaseLetters: 0,
      countOfDigits: 0,
      countOfSpecialCharacters: 0,
      maximumNumberOfSpecialCharactersPossible: 0,
    );
  }

  final int countOfDigits;
  final int countOfLowerCaseLetters;
  final int countOfSpecialCharacters;
  final int countOfUpperCaseLetters;
  final int maximumNumberOfSpecialCharactersPossible;
  final int passwordLength;
  final PasswordSafetyLevel passwordSafetyLevel;
  final int passwordStrength;
}

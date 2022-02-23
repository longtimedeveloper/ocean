import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('PasswordStrength', () {
    test('good password tests', () {
      // arrange

      // act
      final result = PasswordStrength.calculate('129496&zbZ*(', OceanStringWordConstants.defaultSpecialCharacters, 12,
          LowerCaseCharacter.yes, UpperCaseCharacter.yes, DigitCharacter.yes, SpecialCharacter.yes);

      // assert
      expect(result.countOfDigits, 6);
      expect(result.countOfLowerCaseLetters, 2);
      expect(result.countOfSpecialCharacters, 3);
      expect(result.countOfUpperCaseLetters, 1);
      expect(result.maximumNumberOfSpecialCharactersPossible, 14);
      expect(result.passwordLength, 12);
      expect(result.passwordSafetyLevel, PasswordSafetyLevel.high);
      expect(result.passwordStrength, 100);
    });

    test('bad password tests', () {
      // arrange

      // act
      final result = PasswordStrength.calculate('', OceanStringWordConstants.defaultSpecialCharacters, 12,
          LowerCaseCharacter.yes, UpperCaseCharacter.yes, DigitCharacter.yes, SpecialCharacter.yes);

      // assert
      expect(result.passwordSafetyLevel, PasswordSafetyLevel.unsafe);
    });

    test('medium password tests', () {
      // arrange

      // act
      final result = PasswordStrength.calculate('1296&zbZ*(', OceanStringWordConstants.defaultSpecialCharacters, 12,
          LowerCaseCharacter.yes, UpperCaseCharacter.yes, DigitCharacter.yes, SpecialCharacter.yes);

      // assert
      expect(result.passwordSafetyLevel, PasswordSafetyLevel.medium);
    });

    test('low password tests', () {
      // arrange

      // act
      final result = PasswordStrength.calculate('16&zbZ*(', OceanStringWordConstants.defaultSpecialCharacters, 12,
          LowerCaseCharacter.yes, UpperCaseCharacter.yes, DigitCharacter.yes, SpecialCharacter.yes);

      // assert
      expect(result.passwordSafetyLevel, PasswordSafetyLevel.low);
    });
  });
}

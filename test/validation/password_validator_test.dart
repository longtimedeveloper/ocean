import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('PasswordValidator', () {
    test('validates default settings', () {
      void testRunner(String propertyName, int minimumLength, int maximumLength, String allowedPasswordSpecialCharacters,
          String businessObjectActiveRuleSet, dynamic value, String expectedMessage, bool expectedIsValid,
          {digitCharacter = DigitCharacter.yes,
          lowerCaseCharacter = LowerCaseCharacter.yes,
          upperCaseCharacter = UpperCaseCharacter.yes,
          specialCharacter = SpecialCharacter.yes,
          allowSequencesOrRepeatedCharacters = AllowSequencesOrRepeatedCharacters.no,
          String ruleSet = OceanStringCharacterConstants.stringEmpty,
          String friendlyName = OceanStringCharacterConstants.stringEmpty,
          String additionalMessage = OceanStringCharacterConstants.stringEmpty,
          String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no}) {
        // arrange
        final sut = PasswordValidator(propertyName, minimumLength, maximumLength, allowedPasswordSpecialCharacters,
            digitCharacter: digitCharacter,
            lowerCaseCharacter: lowerCaseCharacter,
            upperCaseCharacter: upperCaseCharacter,
            specialCharacter: specialCharacter,
            allowSequencesOrRepeatedCharacters: allowSequencesOrRepeatedCharacters,
            ruleSet: ruleSet,
            friendlyName: friendlyName,
            additionalMessage: additionalMessage,
            overrideErrorMessage: overrideErrorMessage,
            allowNullValue: allowNullValue);

        // act
        final result = sut.validate(value, businessObjectActiveRuleSet);

        // assert
        if (result.isNotValid) {
          expect(result.brokenRule!.errorMessage, expectedMessage);
          expect(result.brokenRule!.propertyName, propertyName);
          expect(result.brokenRule!.ruleTypeName, 'PasswordValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'Z7&toyrZ', '', true);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'Z7toyrZ', 'Password must have at least one of these special characters !@#\$*&^-_+|()%', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'Z7%ADGA', 'Password must have at least one lower case letter', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'z7%zadga', 'Password must have at least one upper case letter', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'zz%zzZzz', 'Password must have at least one digit', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert, 'zz',
          'Password is shorter than 6.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'zzasdfs&adfsadfsadfsdf', 'Password is longer than 12.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'ZZZ&to125', 'Password must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'Z123&to125', 'Password must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          '1254789!Zr', 'Password must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          '12547=<89!Zr', 'Password has these invalid special characters: =<', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          '12547<89!Zr', 'Password has this invalid special character: <', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert, null,
          'Password null value is not allowed.', false);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert, null,
          '', true,
          allowNullValue: AllowNullValue.yes);
      testRunner('password', 6, 12, OceanStringWordConstants.defaultSpecialCharacters, OceanValidationConstants.insert,
          'zz%zzZzz><', 'Password must have at least one digit\nPassword has these invalid special characters: ><', false);
      testRunner(
          'password',
          6,
          12,
          OceanStringWordConstants.defaultSpecialCharacters,
          OceanValidationConstants.insert,
          'zz%zzZzzz',
          'Password must have at least one digit\nPassword must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.',
          false);
      testRunner(
          'password',
          6,
          12,
          OceanStringWordConstants.defaultSpecialCharacters,
          OceanValidationConstants.insert,
          'zz%zzABC',
          'Password must have at least one digit\nPassword must not have repeating patterns like: 123 321 abc CBA 111 zzz, etc.',
          false);
    });

    test('exception thrown when property name is empty', () {
      expect(() => PasswordValidator('', 1, 2, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when special characters are empty and specialCharacter == SpecialCharacter.yes.', () {
      expect(() => PasswordValidator('propertyName', 1, 25, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when minimum length is less than zer', () {
      expect(() => PasswordValidator('propertyName', -1, 25, '!&'), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when maximum length is less than minimum', () {
      expect(() => PasswordValidator('propertyName', 10, 9, '!&'), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not an int', () {
      final sut = PasswordValidator('propertyName', 10, 12, '!&');
      expect(() => sut.validate(2, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = PasswordValidator('propertyName', 10, 12, '!&');
      expect(() => sut.validate('asdf', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('RegularExpressionValidator', () {
    test('RegularExpressionValidator', () {
      void testRunner(String propertyName, RegularExpressionPatternType regularExpressionPatternType,
          String businessObjectActiveRuleSet, dynamic value, String expectedMessage, bool expectedIsValid,
          {RequiredEntry requiredEntry = RequiredEntry.yes,
          String ruleSet = StringCharacterConstants.stringEmpty,
          String friendlyName = StringCharacterConstants.stringEmpty,
          String additionalMessage = StringCharacterConstants.stringEmpty,
          String overrideErrorMessage = StringCharacterConstants.stringEmpty,
          AllowNullValue allowNullValue = AllowNullValue.no}) {
        // arrange
        final sut = RegularExpressionValidator(propertyName, regularExpressionPatternType,
            requiredEntry: requiredEntry,
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
          expect(result.brokenRule!.ruleTypeName, 'RegularExpressionValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner(
          'cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, '555.555.1212', '', true);
      testRunner(
          'cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, '555-555-1212', '', true);
      testRunner(
          'cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, '(555) 555-1212', '', true);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert,
          '(555) 555-1212 Ext 105', '', true);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert,
          '(555) 555-1212 Ex 105', '', true);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert,
          '(555) 555-1212 Call after 5', '', true);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert,
          '(55)555-1212 Call after 5', 'Cell Phone did not match the required US phone number pattern.', false);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, null,
          'Cell Phone null value is not allowed.', false);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, null, '', true,
          allowNullValue: AllowNullValue.yes);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, '', '', true,
          requiredEntry: RequiredEntry.no);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, null, '', true,
          ruleSet: ValidationConstants.delete);
      testRunner('cellPhone', RegularExpressionPatternType.usPhoneNumber, ValidationConstants.insert, '',
          'Cell Phone is required.', false);

      testRunner('email', RegularExpressionPatternType.email, ValidationConstants.insert, 'k@k.com', '', true);
      testRunner('ipaddress', RegularExpressionPatternType.ipAddress, ValidationConstants.insert, '10.0.0.1', '', true);
      testRunner('ssn', RegularExpressionPatternType.ssn, ValidationConstants.insert, '555-55-5555', '', true);

      testRunner(
          'url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'https://google.com', '', true);
      testRunner(
          'url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'http://google.com', '', true);
      testRunner('url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'https://www.google.com',
          '', true);
      testRunner(
          'url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'https://120.5.3.1', '', true);
      testRunner(
          'url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'ftp://google.com', '', true);
      testRunner(
          'url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'ftp://120.0.2.6', '', true);
      testRunner('url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'google.com',
          'Url did not match the required URL pattern.', false);
      testRunner('url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'google',
          'Url did not match the required URL pattern.', false);
      testRunner('url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, 'http:/google.com',
          'Url did not match the required URL pattern.', false);
      testRunner('url', RegularExpressionPatternType.urlHttpHttpsFtp, ValidationConstants.insert, '11111',
          'Url did not match the required URL pattern.', false);

      testRunner('zip', RegularExpressionPatternType.usZipCode, ValidationConstants.insert, '47331', '', true);
      testRunner('zip', RegularExpressionPatternType.usZipCode, ValidationConstants.insert, '47331-001', '', true);
    });

    test('exception thrown when property name is empty', () {
      expect(() => RegularExpressionValidator('', RegularExpressionPatternType.email),
          throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      final sut = RegularExpressionValidator('propertyName', RegularExpressionPatternType.email);
      expect(() => sut.validate(2, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      final sut = RegularExpressionValidator('propertyName', RegularExpressionPatternType.email);
      expect(() => sut.validate('asdf', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when pattern type is invalid', () {
      final sut = RegularExpressionValidator.customRegularExpression('propertyName', '[a-z]+');
      final result = sut.validate('adfa', ValidationConstants.insert);
      expect(result.isValid, true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('DomainValidator', () {
    test('validates entry ensuring value is contained in the domain', () {
      void testRunner(
        String propertyName,
        List<String> data,
        String businessObjectActiveRuleSet,
        dynamic value,
        String? expectedMessage,
        bool expectedIsValid, {
        RequiredEntry requiredEntry = RequiredEntry.yes,
        String ruleSet = OceanStringCharacterConstants.stringEmpty,
        String friendlyName = OceanStringCharacterConstants.stringEmpty,
        String additionalMessage = OceanStringCharacterConstants.stringEmpty,
        String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
        AllowNullValue allowNullValue = AllowNullValue.no,
      }) {
        // arrange
        final sut = DomainValidator(propertyName, data,
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
          expect(result.brokenRule!.ruleTypeName, 'DomainValidator');
        }
        expect(result.isValid, expectedIsValid);
      }

      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, 'abc', null, true);
      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, 'abdc',
          'Type abdc did not match any of the acceptable values abc, def.', false);

      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, null, 'Type null value is not allowed.', false,
          allowNullValue: AllowNullValue.no);
      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, null, null, true,
          allowNullValue: AllowNullValue.yes);
      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, '', null, true, requiredEntry: RequiredEntry.no);
      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, 'abdc', null, true,
          ruleSet: OceanValidationConstants.update);
      testRunner('type', ['abc', 'def'], OceanValidationConstants.insert, '', 'Type is required.', false,
          requiredEntry: RequiredEntry.yes);
    });

    test('exception thrown when property name is empty', () {
      expect(() => DomainValidator('', ['abc', 'def']), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when data is empty', () {
      expect(() => DomainValidator('propertyName', []), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when value is not a string', () {
      // arrange
      final sut = DomainValidator('propertyName', ['abc', 'def']);
      // act
      // assert
      expect(() => sut.validate(99661, ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });

    test('exception thrown when businessObjectActiveRuleSet is empty', () {
      // arrange
      final sut = DomainValidator('propertyName', ['abc', 'def']);
      // act
      // assert
      expect(() => sut.validate('074909661', ''), throwsA(const TypeMatcher<OceanArgumentException>()));
    });
  });
}

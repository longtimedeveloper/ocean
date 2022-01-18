import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

import '../models/demo_model/demo.dart';
import '../services/services.dart';

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  group('ComparePropertyValidator', () {
    test('Compare first name and last name', () {
      void testRunner(String propertyName, String firstName, String lastName, String? expectedMessage,
          {String businessObjectActiveRuleSet = ValidationConstants.insert}) {
        // arrange
        final sut = Demo.create();
        sut.activeRuleSet = businessObjectActiveRuleSet;
        sut.firstName = firstName;
        sut.lastName = lastName;

        // act
        final result = sut.checkAllRulesForProperty(propertyName, lastName);

        // assert
        expect(result, expectedMessage);
      }

      testRunner(Demo.lastNamePropertyName, 'Karl', 'Karl', 'Last Name must not be equal to First Name.');
      testRunner(Demo.lastNamePropertyName, 'Karl', 'Karls', null);
    });

    test('Throws when activeRuleSet is empty.', () {
      // arrange
      final sut = ComparePropertyValidator(Demo.firstNamePropertyName, Demo.lastNamePropertyName, ComparisionType.notEqual);

      // act

      // assert
      expect(() => sut.validate('ok', ''), throwsA(isInstanceOf<OceanArgumentException>()));
    });

    test('Throws when constructor arguments are invalid.', () {
      expect(() => ComparePropertyValidator('', Demo.passwordPropertyName, ComparisionType.equal, ruleSet: ''),
          throwsA(isInstanceOf<OceanArgumentException>()));
      expect(() => ComparePropertyValidator(Demo.passwordPropertyName, '', ComparisionType.equal, ruleSet: ''),
          throwsA(isInstanceOf<OceanArgumentException>()));
      expect(
          () => ComparePropertyValidator(Demo.passwordPropertyName, Demo.passwordPropertyName, ComparisionType.equal,
              ruleSet: ''),
          throwsA(isInstanceOf<OceanArgumentException>()));
    });

    test('Skips when rule sets do not match', () {
      // arrange
      final sut = ComparePropertyValidator(Demo.firstNamePropertyName, Demo.lastNamePropertyName, ComparisionType.notEqual,
          ruleSet: ValidationConstants.delete);

      // act
      final result = sut.validate('abc', ValidationConstants.insert);

      // assert
      expect(result.isValid, true);
    });

    test('Resolves compare to friendly name', () {
      // arrange
      final sut = ComparePropertyValidator(Demo.firstNamePropertyName, Demo.lastNamePropertyName, ComparisionType.notEqual,
          compareToPropertyFriendlyName: 'Dart');

      // act
      final result = sut.validate('abc', ValidationConstants.insert, optionalValue: 'abcd');

      // assert
      expect(result.isValid, true);
      expect(sut.compareToPropertyFriendlyName, 'Dart');
    });
  });
}

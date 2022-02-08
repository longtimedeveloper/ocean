import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';
import '../models/models.dart';
import '../services/services.dart';

String? verifyTrue(String propertyName, value) {
  if (value is bool) {
    if (!value) {
      return 'custom error';
    }
  }
  return null;
}

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  test('business object processExternalValidation', () {
    // arrange
    final sut = UserOptions.create();
    sut.acknowledgeClubTerms = true;
    sut.acknowledgeTerms = true;
    sut.joinClub = true;
    sut.joinMarketingMessages = true;
    expect(sut.isValid, true);

    // act
    sut.setProcessExternalValidation(verifyTrue);
    sut.joinClub = false;
    expect(sut.isValid, false);
    expect(sut.getPropertyErrors(UserOptions.joinClubPropertyName), 'custom error');
    sut.joinClub = true;
    expect(sut.getPropertyErrors(UserOptions.joinClubPropertyName), null);
    expect(sut.isValid, true);

    // assert
  });

  test('business object onPropertyChanged', () {
    // arrange
    final sut = UserOptions.create();
    sut.acknowledgeClubTerms = true;
    sut.acknowledgeTerms = true;
    sut.joinClub = true;
    sut.joinMarketingMessages = true;
    expect(sut.isValid, true);
    bool callbackCalled = false;
    sut.setOnPropertyChangedCallback((p0, p1) {
      callbackCalled = true;
    });

    // act
    sut.joinClub = false;

    // assert
    expect(callbackCalled, true);
  });

  test('given same value, two property values match', () {
    // arrange
    final sut = Demo.create();
    sut.firstName = 'ocean';
    sut.lastName = 'ocean';

    // act
    final otherProperty = sut.getPropertyValue(Demo.lastNamePropertyName);

    // assert
    expect(otherProperty == sut.firstName, true);
  });

  test('given different values, two property values do not match', () {
    // arrange
    final sut = Demo.create();
    sut.firstName = 'ocean';
    sut.lastName = 'oceanwaves';

    // act
    final otherProperty = sut.getPropertyValue(Demo.lastNamePropertyName);

    // assert
    expect(otherProperty != sut.firstName, true);
  });

  test('string and int property types do not match', () {
    // arrange
    final sut = Demo.create();
    sut.firstName = '30';
    sut.age = 30;

    // act
    final otherProperty = sut.getPropertyValue(Demo.agePropertyName);

    // assert
    expect(otherProperty != sut.firstName, true);
  });

  test('given same number value, two number property values match', () {
    // arrange
    final sut = Demo.create();
    sut.age = 30;
    sut.favorites = 30;

    // act
    final otherProperty = sut.getPropertyValue(Demo.favoritesPropertyName);

    // assert
    expect(otherProperty == sut.age, true);
  });

  test('exception thrown when property name not found.', () {
    // arrange
    final sut = Demo.create();

    // act

    // assert
    expect(() => sut.getPropertyValue('willnotfindme'), throwsA(const TypeMatcher<OceanArgumentException>()));
  });

  test('accessing and testing business object base properties', () {
    final sut = Demo.createAndPopulate();
    expect(sut.isValid, true);
    expect(sut.isNotValid, false);
    expect(sut.isDirty, false);
    expect(sut.isNotDirty, true);
    expect(sut.getEntityErrors() == null, true);
    expect(sut.activeRuleSet, ValidationConstants.insert);
    expect(sut.businessObjectRuntimeType.toString(), 'Demo');
    expect(sut.getPropertyValue(Demo.firstNamePropertyName), 'Dart');
    sut.dummy = 'HI';
    expect(sut.isDirty, true);
    expect(sut.isNotDirty, false);
    sut.resetAfterSaving();
    expect(sut.isDirty, false);
    expect(sut.isNotDirty, true);

    sut.firstName = '';
    final errors = sut.getEntityErrors();

    expect(errors != null && errors.isNotEmpty, true);
    expect(sut.isDirty, true);
    expect(sut.isValid, false);

    sut.beginUIEditingMode();
    sut.firstName = 'dart';
    sut.endUIEditingModel();

    expect(sut.firstName, 'dart');
    sut.firstName = 'dart';
    expect(sut.firstName, 'Dart');

    sut.dummy = 'not';
    sut.resetAfterSaving();
    expect(sut.isDirty, false);
    sut.dummy = null;
    expect(sut.isDirty, true);
    expect(sut.isValid, true);

    sut.addExternalValidationRuleBrokenRule(Demo.firstNamePropertyName, 'crazyrule', 'crazy rule broken');
    expect(sut.isValid, false);
    var externalErrors = sut.getPropertyErrors(Demo.firstNamePropertyName);
    expect(externalErrors != null && externalErrors.isNotEmpty, true);
    expect(externalErrors, 'crazy rule broken');
    sut.removeExternalValidationRuleBrokenRule(Demo.firstNamePropertyName, 'crazyrule');
    externalErrors = sut.getPropertyErrors(Demo.firstNamePropertyName);
    expect(externalErrors == null, true);
    externalErrors = sut.getEntityErrors();
    expect(externalErrors == null, true);
    expect(sut.isValid, true);
    expect(() => sut.activeRuleSet = ValidationConstants.insertDeleteUpdate, throwsA(const TypeMatcher<OceanException>()));
    expect(() => sut.checkAllRulesForProperty('', 5), throwsA(const TypeMatcher<OceanException>()));
    expect(() => sut.setPropertyValue('', 'Test', null), throwsA(const TypeMatcher<OceanException>()));
  });

  Future<void> check(Demo sut) async {
    sut.setPropertyValue('firstName', 'Test', null);
    sut.checkAllRulesForProperty('firstName', null);
    sut.firstName = 'Test';
  }

  group('business object base async callback', () {
    bool hasBeenCalled = false;
    setUp(() {
      final sut = Demo.createAndPopulate();
      sut.setIsValidCallback((value) {
        hasBeenCalled = true;
      });
      sut.firstName = '';

      return Future(() async {
        await check(sut);
      });
    });
    test('verify callback was invoked when isValid changed.', () {
      expect(hasBeenCalled, true);
    });
  });
}

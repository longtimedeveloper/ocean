import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

import '../models/models.dart';
import '../services/bootstrap.dart';

void main() {
  bool hasBeenBootstrapped = false;
  setUp(() {
    if (!hasBeenBootstrapped) {
      bootstrap();
      hasBeenBootstrapped = true;
    }
  });

  test('TextInputFormMetadataFacade normal', () {
    // arrange
    final demo = Demo.createAndPopulate();
    final config = FormMetadataFacadeConfig<String>(
        propertyName: Demo.firstNamePropertyName,
        businessObjectBase: demo,
        propertySetter: (value) => demo.firstName = value,
        propertyGetter: () => demo.firstName);
    final sut = TextInputFormMetadataFacade<String>(config);

    // act
    sut.checkAllRules();
    demo.firstName = 'Test';
    sut.checkAllRulesForProperty('Test');

    // assert
    expect(sut.helperText, null);
    expect(sut.hintText, null);
    expect(sut.keyBoardType, TextInputType.name);
    expect(sut.labelText, 'First Name');
    expect(sut.maximumLength, 25);
    expect(sut.isValid(), true);
    expect(sut.getPropertyValue(), 'Test');

    sut.setFormatedPropertyValue('test');
    expect(sut.getPropertyValue(), 'Test');
    expect(sut.validateProperty('Test'), null);
    sut.setPropertyValue('test');
    expect(sut.getPropertyValue(), 'test');

    expect(sut.isValid(), true);
    sut.addExternalValidationRuleBrokenRule('ruleTypeName', 'errorMessage');
    expect(sut.isValid(), false);
    sut.removeExternalValidationRuleBrokenRule('ruleTypeName');
    expect(sut.isValid(), true);
  });

  test('TextInputFormMetadataFacade throws if PropertyMetadata is not found for propertyName', () {
    final demo = Demo.create();
    expect(
        () => TextInputFormMetadataFacade<String>(FormMetadataFacadeConfig<String>(
            propertyName: 'willneverfindme',
            businessObjectBase: demo,
            propertySetter: (value) => demo.firstName = value,
            propertyGetter: () => demo.firstName)),
        throwsA(const TypeMatcher<OceanException>()));
  });
}

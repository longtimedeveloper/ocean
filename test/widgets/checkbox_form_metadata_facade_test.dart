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

  test('FormMetadataFacade normal', () {
    // arrange
    final userOptions = UserOptions.create();
    userOptions.acknowledgeClubTerms = true;
    userOptions.acknowledgeTerms = true;
    final config = FormMetadataFacadeConfig<bool>(
        propertyName: UserOptions.acknowledgeTermsPropertyName,
        businessObjectBase: userOptions,
        propertySetter: (value) => userOptions.acknowledgeTerms = value,
        propertyGetter: () => userOptions.acknowledgeTerms);
    final sut = CheckboxFormMetadataFacade<bool>(config);

    // act

    // assert
    expect(sut.isValid(), true);
    expect(sut.autoFocus, true);
    expect(sut.subtitleText, null);
    expect(sut.titleText, 'Acknowledge Terms and Conditions');
    expect(sut.getPropertyValue(), true);
    sut.setPropertyValue(false);
    expect(sut.validateProperty(false), 'Required');
    expect(sut.isValid(), false);
    sut.setFormatedPropertyValue(true);
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

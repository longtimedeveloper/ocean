import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('StringFormatRulesManager empty', () {
    // arrange
    final sut = StringFormatRulesManager();

    // act

    // assert
    expect(sut.hasRules, false);
    expect(sut.rules, {});
    expect(sut.hasRuleForProperty('propertyName'), false);
    expect(sut.getRuleForProperty('propertyName'), null);
  });

  test('StringFormatRulesManager normal', () {
    // arrange
    final sut = StringFormatRulesManager();

    // act
    sut.addRule('firstName', StringFormatRule(stringCase: StringCase.lower));
    final StringFormatRule? result = sut.getRuleForProperty('firstName');

    // assert
    expect(sut.hasRules, true);
    expect(sut.hasRuleForProperty('firstName'), true);
    expect(result != null, true);
  });

  test('PropertyMetadataManager propertyName empty throws', () {
    // arrange
    final sut = StringFormatRulesManager();

    // act

    // assert
    expect(() => sut.addRule('', StringFormatRule(stringCase: StringCase.lower)),
        throwsA(const TypeMatcher<OceanArgumentException>()));
  });

  test('StringFormatRulesManager adding duplicate throws', () {
    // arrange
    final sut = StringFormatRulesManager();

    // act
    sut.addRule('firstName', StringFormatRule(stringCase: StringCase.lower));

    // assert
    expect(() => sut.addRule('firstName', StringFormatRule(stringCase: StringCase.lower)),
        throwsA(const TypeMatcher<OceanArgumentException>()));
  });
}

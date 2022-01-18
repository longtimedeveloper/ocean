import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('StateAbbreviationNameTool normal', () {
    // arrange
    final result = StateAbbreviationNameTool.instance.getStateAbbreviationAndNames();
    final resultTwo = StateAbbreviationNameTool.instance.getStateAbbreviationAndNames(includeOtherAEEntries: true);
    final indiana = StateAbbreviationNameTool.instance.getStateName('IN');
    // act

    // assert
    expect(result.isNotEmpty, true);
    expect(resultTwo.isNotEmpty, true);
    expect(indiana, 'Indiana');
  });

  test('StateAbbreviationNameTool getStateName throws when stateAbbreviation is not valid', () {
    expect(
        () => StateAbbreviationNameTool.instance.getStateName('ZZ'), throwsA(const TypeMatcher<OceanArgumentException>()));
  });
}

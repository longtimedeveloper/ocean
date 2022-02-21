import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('SharedStringCasingChecks getStringCasingChecks throws when empty', () {
    expect(() => SharedStringCasingChecks.instance.getStringCasingChecks, throwsA(const TypeMatcher<OceanException>()));
  });

  test('SharedStringCasingChecks addStringCasingCheck throws when empty', () {
    expect(
        () => SharedStringCasingChecks.instance
            .addStringCasingCheck(StringCasingCheck(id: 'dummy', lookFor: 'a', replaceWith: 'A')),
        throwsA(const TypeMatcher<OceanException>()));
  });

  test('SharedStringCasingChecks addStringCasingCheck normal', () {
    // arrange
    final list = <StringCasingCheck>[];
    list.add(StringCasingCheck(id: 'dummy', lookFor: 'a', replaceWith: 'A'));

    // act
    SharedStringCasingChecks.instance.loadChecks(list);
    SharedStringCasingChecks.instance.addStringCasingCheck(StringCasingCheck(id: 'dummy', lookFor: 'b', replaceWith: 'B'));
    final result = SharedStringCasingChecks.instance.getStringCasingChecks;
    // assert
    expect(result.length, 2);
  });
}

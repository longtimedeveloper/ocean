import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('StringCasingCheck throws when lookFor and replaceWith lengths are different', () {
    expect(() => StringCasingCheck(lookFor: 'a', replaceWith: 'aa'), throwsA(const TypeMatcher<OceanArgumentException>()));
  });
}

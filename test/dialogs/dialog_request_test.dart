import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('DialogRequest', () {
    test('DialogButtons must have at least one button, otherwise, throws.', () {
      // arrange

      // act

      // assert
      expect(() => DialogRequest(key: 'key', title: 'title', description: 'description', dialogButtons: DialogButtons()),
          throwsA(const TypeMatcher<OceanException>()));
    });
  });
}

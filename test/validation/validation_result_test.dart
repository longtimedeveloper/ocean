import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('ValidationResult.success', () {
    // arrange
    final sut = ValidationResult.success();

    // act

    // assert
    expect(sut.isValid, true);
  });
}

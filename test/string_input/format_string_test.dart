import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('Tests for String Formatting', () {
    test('String extension formatString with one argument', () {
      // arrange
      const String template = 'my before text {0}, my after text.';
      const String expected = 'my before text 100, my after text.';
      // act
      final result = template.formatString(100);

      // assert
      expect(result, expected);
    });
    test('String extension formatString with two arguments', () {
      // arrange
      const String template = 'my before text {0}, my after text {1}.';
      const String expected = 'my before text 100, my after text hello.';
      // act
      final result = template.formatString(100, 'hello');

      // assert
      expect(result, expected);
    });
  });
}

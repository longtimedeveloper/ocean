import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CommandGenericAlwaysEnabled<T>', () {
    test('executeMethod is invoked when execute is invoked.', () {
      // arrange
      bool executeMethodCalled = false;
      final sut = CommandGenericAlwaysEnabled<String>(
        executeMethod: (value) => executeMethodCalled = true,
      );

      // act
      sut.execute('');

      // assert
      expect(executeMethodCalled, true);
    });
  });
}

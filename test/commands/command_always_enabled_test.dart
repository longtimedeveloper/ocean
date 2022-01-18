import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CommandAlwaysEnabled', () {
    test('executeMethod is invoked when execute is invoked.', () {
      // arrange
      bool executeMethodCalled = false;
      final sut = CommandAlwaysEnabled(
        executeMethod: () => executeMethodCalled = true,
      );

      // act
      sut.execute();

      // assert
      expect(executeMethodCalled, true);
    });
  });
}

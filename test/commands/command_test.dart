import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('Command', () {
    test('executeMethod is invoked when execute is invoked.', () {
      // arrange
      bool executeMethodCalled = false;
      final sut = Command(executeMethod: () => executeMethodCalled = true);

      // act
      sut.execute();

      // assert
      expect(executeMethodCalled, false);

      sut.notifyCanExecuteChanged(true);
      sut.execute();

      expect(executeMethodCalled, true);
    });

    test('calling dispose removes listeners', () {
      // arrange

      bool listenerCalled = false;
      final sut = Command(
        executeMethod: () {},
      );
      sut.canExecuteNotifier.addListener(() {
        listenerCalled = true;
      });

      // act
      sut.notifyCanExecuteChanged(true);

      // assert
      expect(listenerCalled, true);

      sut.dispose();
      listenerCalled = false;
      sut.notifyCanExecuteChanged(true);
      expect(listenerCalled, false);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CancelCommand', () {
    test('executeMethod is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.cancelInvoked, false);
      sut.cancelCommand.execute();
      expect(sut.cancelCommand.canExecute, true);
      sut.cancelCommand.execute();
      sut.cancelCommand.notifyCanExecuteChanged(false);
      expect(sut.cancelCommand.canExecute, false);

      // assert
      expect(sut.cancelInvoked, true);
    });
  });
}

class ViewModel with CancelCommand {
  bool cancelInvoked = false;

  @override
  void cancel() {
    cancelInvoked = true;
  }
}

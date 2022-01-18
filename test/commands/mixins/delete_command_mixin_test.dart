import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('DeleteCommand', () {
    test('delete is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.deleteInvoked, false);
      expect(sut.deleteCommand.canExecute, false);
      sut.deleteCommand.notifyCanExecuteChanged(true);
      expect(sut.deleteCommand.canExecute, true);
      sut.deleteCommand.execute();

      // assert
      expect(sut.deleteInvoked, true);
    });
  });
}

class ViewModel with DeleteCommand {
  bool deleteInvoked = false;

  @override
  void delete() {
    deleteInvoked = true;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('RegisterCommand', () {
    test('register is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.registerInvoked, false);
      expect(sut.registerCommand.canExecute, true);
      sut.registerCommand.execute();
      sut.registerCommand.notifyCanExecuteChanged(false);
      expect(sut.registerCommand.canExecute, false);

      // assert
      expect(sut.registerInvoked, true);
    });
  });
}

class ViewModel with RegisterCommand {
  bool registerInvoked = false;

  @override
  void register() {
    registerInvoked = true;
  }
}

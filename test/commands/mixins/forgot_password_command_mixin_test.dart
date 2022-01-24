import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('ForgotPasswordCommand', () {
    test('forgotPassword is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.forgotPasswordInvoked, false);
      expect(sut.forgotPasswordCommand.canExecute, true);
      sut.forgotPasswordCommand.execute();
      sut.forgotPasswordCommand.notifyCanExecuteChanged(false);
      expect(sut.forgotPasswordCommand.canExecute, false);

      // assert
      expect(sut.forgotPasswordInvoked, true);
    });
  });
}

class ViewModel with ForgotPasswordCommand {
  bool forgotPasswordInvoked = false;

  @override
  void forgotPassword() {
    forgotPasswordInvoked = true;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('ResetPasswordCommand', () {
    test('resetPassword is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.resetPasswordInvoked, false);
      expect(sut.resetPasswordCommandCommand.canExecute, true);
      sut.resetPasswordCommandCommand.execute();
      sut.resetPasswordCommandCommand.notifyCanExecuteChanged(false);
      expect(sut.resetPasswordCommandCommand.canExecute, false);

      // assert
      expect(sut.resetPasswordInvoked, true);
    });
  });
}

class ViewModel with ResetPasswordCommand {
  bool resetPasswordInvoked = false;

  @override
  void resetPassword() {
    resetPasswordInvoked = true;
  }
}

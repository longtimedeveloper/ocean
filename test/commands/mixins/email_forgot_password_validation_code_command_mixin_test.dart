import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('EmailForgotPasswordValidationCodeCommand', () {
    test('emailForgotPasswordValidationCode is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.emailForgotPasswordValidationCodeInvoked, false);
      expect(sut.emailForgotPasswordValidationCodeCommand.canExecute, true);
      sut.emailForgotPasswordValidationCodeCommand.execute();
      sut.emailForgotPasswordValidationCodeCommand.notifyCanExecuteChanged(false);
      expect(sut.emailForgotPasswordValidationCodeCommand.canExecute, false);

      // assert
      expect(sut.emailForgotPasswordValidationCodeInvoked, true);
    });
  });
}

class ViewModel with EmailForgotPasswordValidationCodeCommand {
  bool emailForgotPasswordValidationCodeInvoked = false;

  @override
  void emailForgotPasswordValidationCode() {
    emailForgotPasswordValidationCodeInvoked = true;
  }
}

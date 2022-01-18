import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('ForgotPasswordAlwaysEnabledCommand', () {
    test('forgotPassword is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.forgotPasswordInvoked, false);
      sut.forgotPasswordCommand.execute();

      // assert
      expect(sut.forgotPasswordInvoked, true);
    });
  });
}

class ViewModel with ForgotPasswordAlwaysEnabledCommand {
  bool forgotPasswordInvoked = false;

  @override
  void forgotPassword() {
    forgotPasswordInvoked = true;
  }
}

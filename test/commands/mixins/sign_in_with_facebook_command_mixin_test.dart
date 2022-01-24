import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInWithFacebookCommand', () {
    test('signInWithFacebook is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInWithFacebookInvoked, false);
      sut.signInWithFacebookCommand.execute();
      expect(sut.signInWithFacebookCommand.canExecute, true);
      sut.signInWithFacebookCommand.execute();
      sut.signInWithFacebookCommand.notifyCanExecuteChanged(false);
      expect(sut.signInWithFacebookCommand.canExecute, false);

      // assert
      expect(sut.signInWithFacebookInvoked, true);
    });
  });
}

class ViewModel with SignInWithFacebookCommand {
  bool signInWithFacebookInvoked = false;

  @override
  void signInWithFacebook() {
    signInWithFacebookInvoked = true;
  }
}

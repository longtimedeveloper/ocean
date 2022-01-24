import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInWithGoogleCommand', () {
    test('signInWithGoogle is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInWithGoogleInvoked, false);
      sut.signInWithGoogleCommand.execute();
      expect(sut.signInWithGoogleCommand.canExecute, true);
      sut.signInWithGoogleCommand.execute();
      sut.signInWithGoogleCommand.notifyCanExecuteChanged(false);
      expect(sut.signInWithGoogleCommand.canExecute, false);

      // assert
      expect(sut.signInWithGoogleInvoked, true);
    });
  });
}

class ViewModel with SignInWithGoogleCommand {
  bool signInWithGoogleInvoked = false;

  @override
  void signInWithGoogle() {
    signInWithGoogleInvoked = true;
  }
}

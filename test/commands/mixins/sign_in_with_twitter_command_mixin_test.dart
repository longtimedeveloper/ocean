import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInWithTwitterAlwaysEnabledCommand', () {
    test('signInWithTwitter is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInWithTwitterInvoked, false);
      sut.signInWithTwitterCommand.execute();
      expect(sut.signInWithTwitterCommand.canExecute, true);
      sut.signInWithTwitterCommand.execute();
      sut.signInWithTwitterCommand.notifyCanExecuteChanged(false);
      expect(sut.signInWithTwitterCommand.canExecute, false);

      // assert
      expect(sut.signInWithTwitterInvoked, true);
    });
  });
}

class ViewModel with SignInWithTwitterAlwaysEnabledCommand {
  bool signInWithTwitterInvoked = false;

  @override
  void signInWithTwitter() {
    signInWithTwitterInvoked = true;
  }
}

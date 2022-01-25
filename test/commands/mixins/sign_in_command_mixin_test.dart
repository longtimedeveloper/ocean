import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInCommand', () {
    test('signIn is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInInvoked, false);
      expect(sut.signInCommand.canExecute, true);
      sut.signInCommand.execute();
      sut.signInCommand.notifyCanExecuteChanged(false);
      expect(sut.signInCommand.canExecute, false);

      // assert
      expect(sut.signInInvoked, true);
    });
  });
}

class ViewModel with SignInCommand {
  bool signInInvoked = false;

  @override
  void signIn() {
    signInInvoked = true;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInWithFacebookAlwaysEnabledCommand', () {
    test('signInWithFacebook is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInWithFacebookInvoked, false);
      sut.signInWithFacebookCommand.execute();

      // assert
      expect(sut.signInWithFacebookInvoked, true);
    });
  });
}

class ViewModel with SignInWithFacebookAlwaysEnabledCommand {
  bool signInWithFacebookInvoked = false;

  @override
  void signInWithFacebook() {
    signInWithFacebookInvoked = true;
  }
}

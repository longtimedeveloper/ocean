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

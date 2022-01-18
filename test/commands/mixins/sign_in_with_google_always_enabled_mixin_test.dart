import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SignInWithGoogleAlwaysEnabledCommand', () {
    test('signInWithGoogle is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.signInWithGoogleInvoked, false);
      sut.signInWithGoogleCommand.execute();

      // assert
      expect(sut.signInWithGoogleInvoked, true);
    });
  });
}

class ViewModel with SignInWithGoogleAlwaysEnabledCommand {
  bool signInWithGoogleInvoked = false;

  @override
  void signInWithGoogle() {
    signInWithGoogleInvoked = true;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('RegisterAlwaysEnabledCommand', () {
    test('register is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.registerInvoked, false);
      sut.registerCommand.execute();

      // assert
      expect(sut.registerInvoked, true);
    });
  });
}

class ViewModel with RegisterAlwaysEnabledCommand {
  bool registerInvoked = false;

  @override
  void register() {
    registerInvoked = true;
  }
}

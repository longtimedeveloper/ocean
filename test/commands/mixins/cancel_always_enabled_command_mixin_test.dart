import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('CancelAlwaysEnabledCommand', () {
    test('executeMethod is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.cancelInvoked, false);
      sut.cancelCommand.execute();

      // assert
      expect(sut.cancelInvoked, true);
    });
  });
}

class ViewModel with CancelAlwaysEnabledCommand {
  @override
  void cancel() {
    cancelInvoked = true;
  }

  bool cancelInvoked = false;
}

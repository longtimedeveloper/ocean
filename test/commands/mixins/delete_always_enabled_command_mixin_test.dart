import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('DeleteAlwaysEnabledCommand', () {
    test('delete is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.deleteInvoked, false);
      sut.deleteCommand.execute();

      // assert
      expect(sut.deleteInvoked, true);
    });
  });
}

class ViewModel with DeleteAlwaysEnabledCommand {
  bool deleteInvoked = false;

  @override
  void delete() {
    deleteInvoked = true;
  }
}

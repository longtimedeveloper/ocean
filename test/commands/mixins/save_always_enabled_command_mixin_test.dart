import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SaveAlwaysEnabledCommand', () {
    test('save is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.saveInvoked, false);
      sut.saveCommand.execute();

      // assert
      expect(sut.saveInvoked, true);
    });
  });
}

class ViewModel with SaveAlwaysEnabledCommand {
  bool saveInvoked = false;

  @override
  void save() {
    saveInvoked = true;
  }
}

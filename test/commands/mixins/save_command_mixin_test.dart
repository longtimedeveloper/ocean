import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('SaveCommand', () {
    test('save is invoked when execute is invoked.', () {
      // arrange
      final sut = ViewModel();

      // act
      expect(sut.saveInvoked, false);
      expect(sut.saveCommand.canExecute, false);
      sut.saveCommand.notifyCanExecuteChanged(true);
      expect(sut.saveCommand.canExecute, true);
      sut.saveCommand.execute();

      // assert
      expect(sut.saveInvoked, true);
    });
  });
}

class ViewModel with SaveCommand {
  bool saveInvoked = false;

  @override
  void save() {
    saveInvoked = true;
  }
}

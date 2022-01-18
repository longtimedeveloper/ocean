import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('DialogButtons', () {
    test('DialogButtons can not have duplicate dialog positions, otherwise, throws.', () {
      // arrange

      // act

      // assert
      expect(
          () => DialogButtons()
            ..add(
              DialogButtonPosition.left,
              'buttonText',
              'response',
            )
            ..add(
              DialogButtonPosition.left,
              'buttonText',
              'response',
            ),
          throwsA(const TypeMatcher<OceanException>()));
    });

    test('After adding buttons, the list of buttons is correct.', () {
      // arrange

      final dialogButtons = DialogButtons()
        ..add(DialogButtonPosition.left, 'left', 'left')
        ..add(DialogButtonPosition.center, 'center', 'center')
        ..add(DialogButtonPosition.right, 'right', 'right');

      // act
      final buttons = dialogButtons.toList();

      // assert
      expect(dialogButtons.hasEntry(DialogButtonPosition.left), true);
      expect(dialogButtons.hasEntry(DialogButtonPosition.center), true);
      expect(dialogButtons.hasEntry(DialogButtonPosition.right), true);
      expect(dialogButtons.hasEntries(), true);

      expect(buttons.length, 3);

      final getLeft = buttons.singleWhere((element) => element.buttonText == 'left');
      expect(getLeft.response == 'left', true);
    });
  });
}

import 'dart:collection';
import '../src.dart';

class DialogButtons {
  DialogButtons();

  final Map<DialogButtonPosition, DialogButton> _dialogButtons = {};

  void add(DialogButtonPosition dialogButtonPosition, String buttonText, dynamic response) {
    if (hasEntry(dialogButtonPosition)) {
      throw OceanException(
          MessageConstants.duplicateDialogPositionAlreadyAddedFormat.formatString(dialogButtonPosition.toString()));
    }
    _dialogButtons[dialogButtonPosition] = DialogButton(buttonText: buttonText, response: response);
  }

  bool hasEntries() {
    return _dialogButtons.isNotEmpty;
  }

  bool hasEntry(DialogButtonPosition dialogButtonPosition) {
    return _dialogButtons.containsKey(dialogButtonPosition);
  }

  UnmodifiableListView<DialogButton> toList() {
    final dialogButtons = <DialogButton>[];
    if (hasEntry(DialogButtonPosition.left)) {
      dialogButtons.add(_dialogButtons[DialogButtonPosition.left]!);
    }
    if (hasEntry(DialogButtonPosition.center)) {
      dialogButtons.add(_dialogButtons[DialogButtonPosition.center]!);
    }
    if (hasEntry(DialogButtonPosition.right)) {
      dialogButtons.add(_dialogButtons[DialogButtonPosition.right]!);
    }
    return UnmodifiableListView<DialogButton>(dialogButtons);
  }
}

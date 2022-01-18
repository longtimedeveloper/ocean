import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class AppDialogRequestFactories {
  static DialogRequest confirmDelete(String entityName) {
    final dialogButtons = DialogButtons()
      ..add(DialogButtonPosition.left, 'Cancel', false)
      ..add(DialogButtonPosition.right, 'Delete', true);

    return DialogRequest(
      key: DialogType.confirmDelete,
      title: 'Delete $entityName',
      titleIcon: FontAwesomeIcons.question,
      description: 'This ${entityName.toLowerCase()} will be permanently deleted.',
      dialogButtons: dialogButtons,
    );
  }

  static DialogRequest entityGuardViolation(BusinessObjectBase? businessObjectBase) {
    final dialogButtons = DialogButtons()..add(DialogButtonPosition.right, 'OK', true);

    final text =
        businessObjectBase == null ? 'The business object was null.' : 'The ${businessObjectBase.runtimeType} was invalid.';

    return DialogRequest(
      key: DialogType.exception,
      title: 'Entity Guard Violation',
      titleIcon: FontAwesomeIcons.exclamationCircle,
      description: text + '\nThe programmer did not wire up the button and command in the command button widget correctly.',
      dialogButtons: dialogButtons,
    );
  }

  static DialogRequest exception(String message) {
    final dialogButtons = DialogButtons()..add(DialogButtonPosition.right, 'OK', true);

    return DialogRequest(
      key: DialogType.exception,
      title: 'Exception',
      titleIcon: FontAwesomeIcons.exclamationCircle,
      description: message,
      dialogButtons: dialogButtons,
    );
  }
}

import 'package:flutter/widgets.dart';
import 'dialogs.dart';

abstract class DialogRegisterService {
  void registerAppDialog(
      {required dynamic key, required Widget Function(BuildContext, DialogRequest, Function(DialogReponse)) dialogBuilder});
}

import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

import '../src.dart';

class AppDialogs {
  AppDialogs();

  void setup() {
    final _service = locator<DialogRegisterService>();
    _service.registerAppDialog(key: DialogType.normal, dialogBuilder: _normalDialogBuilder);
    _service.registerAppDialog(key: DialogType.confirmDelete, dialogBuilder: _confirmDeleteDialogBuilder);
    _service.registerAppDialog(key: DialogType.exception, dialogBuilder: _exceptionDialogBuilder);
  }

  List<Widget> _buildActions(BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
    final actions = <Widget>[];

    for (var item in dialogRequest.dialogButtons.toList()) {
      actions.add(TextButton(
          onPressed: () {
            dialogComplete(DialogReponse(response: item.response));
            Navigator.of(context).pop();
          },
          child: Text(
            item.buttonText,
            textAlign: TextAlign.right,
          )));
    }

    return actions;
  }

  Widget _buildTitle(DialogRequest dialogRequest, {Color? iconColor, double? iconSize}) {
    if (dialogRequest.titleIcon == null) {
      return Text(dialogRequest.title);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          dialogRequest.titleIcon!,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(dialogRequest.title),
      ],
    );
  }

  Widget _confirmDeleteDialogBuilder(
      BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
    return AlertDialog(
      title: _buildTitle(dialogRequest, iconColor: Colors.blue),
      content: Text(dialogRequest.description),
      actions: _buildActions(context, dialogRequest, dialogComplete),
    );
  }

  Widget _exceptionDialogBuilder(BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
    return AlertDialog(
      title: _buildTitle(dialogRequest, iconColor: Colors.red),
      content: Text(dialogRequest.description),
      actions: _buildActions(context, dialogRequest, dialogComplete),
    );
  }

  Widget _normalDialogBuilder(BuildContext context, DialogRequest dialogRequest, Function(DialogReponse) dialogComplete) {
    return AlertDialog(
      title: _buildTitle(dialogRequest),
      content: Text(dialogRequest.description),
      actions: _buildActions(context, dialogRequest, dialogComplete),
    );
  }
}

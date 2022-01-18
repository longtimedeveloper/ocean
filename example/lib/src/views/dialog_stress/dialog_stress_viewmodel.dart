import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import '../../src.dart';

class DialogStressViewmodel extends ViewmodelBase with DeleteAlwaysEnabledCommand {
  DialogStressViewmodel();

  @override
  void delete() async {
    final confirmation = await showAppDialog(AppDialogRequestFactories.confirmDelete('Customer'));
    if (confirmation.response == true) {
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Delete Confirmed', iconData: Icons.delete_forever));
    }
  }

  @override
  String get viewTitle => 'Stress Dialog API';

  void showStressorDialog() async {
    final confirmation = await showAppDialog(DialogRequest(
        key: DialogType.normal,
        title: 'Background Dialog',
        description: 'This dialog was requested in the backgound.',
        dialogButtons: DialogButtons()..add(DialogButtonPosition.right, 'OK', true)));
    if (confirmation.response == true) {
      showSnackbar(SnackBarRequest(key: SnackBarType.info, text: 'Background Dialog OK'));
    }
  }
}

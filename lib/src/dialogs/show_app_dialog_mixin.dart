import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'dialogs.dart';

mixin ShowAppDialog {
  final _dialogShowService = GetIt.instance.get<DialogShowService>();

  @visibleForTesting
  @protected
  Future<DialogReponse> showAppDialog(DialogRequest dialogRequest) async {
    return await _dialogShowService.showAppDialog(dialogRequest);
  }
}

import 'dart:async';
import 'package:mutex/mutex.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class DialogService implements DialogShowService, DialogRegisterService {
  DialogService(NavigatorService navigatorService) {
    _navigatorService = navigatorService;
  }

  final mutex = Mutex();

  late Completer<DialogReponse>? _dialogCompleter;
  final Map<dynamic, Widget Function(BuildContext, DialogRequest, Function(DialogReponse))> _dialogs = {};

  late final NavigatorService _navigatorService;

  @override
  void registerAppDialog(
      {required dynamic key, required Widget Function(BuildContext, DialogRequest, Function(DialogReponse)) dialogBuilder}) {
    if (_dialogs.containsKey(key)) {
      throw OceanArgumentException(FieldNameConstants.key,
          MessageConstants.duplicateKeyAlreadyAddedFormat.formatString(StringConstants.dialogBuilder));
    }
    _dialogs[key] = dialogBuilder;
  }

  @override
  Future<DialogReponse> showAppDialog(DialogRequest dialogRequest) async {
    return await mutex.protect(() async {
      return _showAppDialog(dialogRequest);
    });
  }

  BuildContext? get navigatorContext {
    return _navigatorService.navigatorKey.currentState?.overlay?.context;
  }

  bool containsAppDialog(dynamic key) {
    return _dialogs.containsKey(key);
  }

  //TODO when they fix the code coverage tool, remove this block of ignores.
  //     for now, required since the tool will not allow ignoring the throw.
  // coverage:ignore-start
  void _dialogComplete(DialogReponse response) {
    if (_dialogCompleter == null) {
      throw OceanException(MessageConstants.dialogCompleterIsNull);
    }

    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
  // coverage:ignore-end

  Future<DialogReponse> _showAppDialog(DialogRequest dialogRequest) {
    if (!_dialogs.containsKey(dialogRequest.key)) {
      throw OceanException(MessageConstants.keyNotFoundFormat.formatString(StringConstants.dialogBuilder));
    }
    final dialog = _dialogs[dialogRequest.key]!;

    _dialogCompleter = Completer<DialogReponse>();

    showDialog(
      context: navigatorContext!,
      barrierDismissible: false,
      builder: (context) {
        return dialog(context, dialogRequest, _dialogComplete);
      },
    );
    return _dialogCompleter!.future;
  }
}

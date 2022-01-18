import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'package:ocean/src/ocean_constants.dart';

class SnackBarService implements SnackBarRegisterService, SnackBarShowService, SnackBarKeyService {
  SnackBarService();

  final GlobalKey<ScaffoldMessengerState> _snackBarKey = GlobalKey<ScaffoldMessengerState>();
  final Map<dynamic, SnackBar Function(SnackBarRequest)> _snackBars = {};

  @override
  void registerSnackbar({required dynamic key, required SnackBar Function(SnackBarRequest) snackBarBuilder}) {
    if (_snackBars.containsKey(key)) {
      throw OceanArgumentException(FieldNameConstants.key,
          MessageConstants.duplicateKeyAlreadyAddedFormat.formatString(StringConstants.snackBarBuilder));
    }
    _snackBars[key] = snackBarBuilder;
  }

  @override
  void showSnackBar(SnackBarRequest snackBarRequest) {
    if (!_snackBars.containsKey(snackBarRequest.key)) {
      throw OceanException(MessageConstants.keyNotFoundFormat.formatString(StringConstants.snackBarBuilder));
    }

    final snackBarBuilder = _snackBars[snackBarRequest.key];
    final snackBar = snackBarBuilder!.call(snackBarRequest);
    _snackBarKey.currentState?.hideCurrentSnackBar();
    _snackBarKey.currentState?.showSnackBar(snackBar);
  }

  @override
  GlobalKey<ScaffoldMessengerState> get snackBarKey {
    return _snackBarKey;
  }
}

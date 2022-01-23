import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'snack_bars.dart';

mixin BuildSnackBar {
  final _service = GetIt.instance.get<SnackBarBuildService>();

  @visibleForTesting
  @protected
  SnackBar buildSnackbar(SnackBarRequest snackBarRequest) {
    return _service.buildSnackBar(snackBarRequest);
  }
}

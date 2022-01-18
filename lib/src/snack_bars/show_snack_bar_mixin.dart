import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'snack_bars.dart';

mixin ShowSnackBar {
  final _service = GetIt.instance.get<SnackBarShowService>();

  @visibleForTesting
  @protected
  void showSnackbar(SnackBarRequest snackBarRequest) {
    _service.showSnackBar(snackBarRequest);
  }
}

import 'package:flutter/material.dart';
import 'snack_bars.dart';

abstract class SnackBarRegisterService {
  void registerSnackbar({required dynamic key, required SnackBar Function(SnackBarRequest) snackBarBuilder});
}

import 'package:flutter/material.dart';

import 'snack_bars.dart';

abstract class SnackBarBuildService {
  SnackBar buildSnackBar(SnackBarRequest snackBarRequest);
}

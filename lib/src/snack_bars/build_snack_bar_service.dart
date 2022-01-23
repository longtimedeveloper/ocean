import 'package:flutter/material.dart';

import 'snack_bars.dart';

abstract class BuildSnackBarService {
  SnackBar buildSnackBar(SnackBarRequest snackBarRequest);
}

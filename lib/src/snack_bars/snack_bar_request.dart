import 'package:flutter/material.dart';

class SnackBarRequest {
  SnackBarRequest({required this.key, required this.text, this.iconData, this.snackBarAction});

  final IconData? iconData;
  final dynamic key;
  final SnackBarAction? snackBarAction;
  final String text;
}

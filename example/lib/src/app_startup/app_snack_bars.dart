import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

import '../src.dart';

class AppSnackBars {
  AppSnackBars();

  static const double iconSize = 28;
  static const double textFontSize = 20;

  void setup() {
    final _service = locator<SnackBarRegisterService>();
    _service.registerSnackbar(key: SnackBarType.info, snackBarBuilder: _createInfoSnackBar);
    _service.registerSnackbar(key: SnackBarType.warning, snackBarBuilder: _createWarningSnackBar);
    _service.registerSnackbar(key: SnackBarType.error, snackBarBuilder: _createErrorSnackBar);
  }

  SnackBar _createErrorSnackBar(SnackBarRequest snackBarRequest) {
    if (snackBarRequest.text.trim().isEmpty) {
      throw Exception(MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.message));
    }

    return _createSnackBar(
      snackBarRequest: snackBarRequest,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      textFontSize: textFontSize,
      iconColor: Colors.white,
      iconSize: iconSize,
      secondsDuration: 4,
    );
  }

  SnackBar _createInfoSnackBar(SnackBarRequest snackBarRequest) {
    if (snackBarRequest.text.trim().isEmpty) {
      throw Exception(MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.message));
    }
    return _createSnackBar(
      snackBarRequest: snackBarRequest,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      textFontSize: textFontSize,
      iconColor: Colors.white,
      iconSize: iconSize,
      secondsDuration: 3,
    );
  }

  SnackBar _createSnackBar(
      {required SnackBarRequest snackBarRequest,
      required Color backgroundColor,
      required Color? textColor,
      required double? textFontSize,
      required Color iconColor,
      required double? iconSize,
      required int secondsDuration}) {
    if (snackBarRequest.text.trim().isEmpty) {
      throw Exception(MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.message));
    }

    return SnackBar(
      content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _createSnackBarChildren(
            snackBarRequest: snackBarRequest,
            textColor: textColor,
            textFontSize: textFontSize,
            iconColor: iconColor,
            iconSize: iconSize,
          )),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: secondsDuration),
      behavior: SnackBarBehavior.fixed,
      action: snackBarRequest.snackBarAction,
    );
  }

  List<Widget> _createSnackBarChildren({
    required SnackBarRequest snackBarRequest,
    required Color? textColor,
    required double? textFontSize,
    required Color? iconColor,
    required double? iconSize,
  }) {
    final List<Widget> widgets = [];
    if (snackBarRequest.iconData == null) {
      widgets.add(Expanded(
        child: Text(snackBarRequest.text, style: TextStyle(color: textColor, fontSize: textFontSize)),
      ));
      return widgets;
    }
    widgets.add(
      Icon(snackBarRequest.iconData, size: iconSize, color: iconColor),
    );
    widgets.add(const SizedBox(width: 16));
    widgets.add(Expanded(
      child: Text(snackBarRequest.text, style: TextStyle(color: textColor, fontSize: textFontSize)),
    ));
    return widgets;
  }

  SnackBar _createWarningSnackBar(SnackBarRequest snackBarRequest) {
    if (snackBarRequest.text.trim().isEmpty) {
      throw Exception(MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.message));
    }

    return _createSnackBar(
      snackBarRequest: snackBarRequest,
      backgroundColor: Colors.amber,
      textColor: Colors.black,
      textFontSize: textFontSize,
      iconColor: Colors.black87,
      iconSize: iconSize,
      secondsDuration: 4,
    );
  }
}

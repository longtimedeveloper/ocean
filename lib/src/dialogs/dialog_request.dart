import 'package:flutter/widgets.dart';
import 'package:ocean/ocean.dart';
import '../ocean_constants.dart';

class DialogRequest {
  DialogRequest(
      {required this.key, required this.title, required this.description, required this.dialogButtons, this.titleIcon}) {
    if (!dialogButtons.hasEntries()) {
      throw OceanException(
          MessageConstants.mapArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.dialogButtons));
    }
  }

  final String description;
  final DialogButtons dialogButtons;
  final dynamic key;
  final String title;
  final IconData? titleIcon;
}

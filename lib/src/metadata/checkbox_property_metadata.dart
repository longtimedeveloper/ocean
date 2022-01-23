import 'package:ocean/src/extensions/ocean_extensions.dart';

import 'metadata.dart';

class CheckboxPropertyMetadata extends PropertyMetadataBase {
  CheckboxPropertyMetadata({
    required String propertyName,
    String? titleText,
    this.subtitleText,
    autoFocus = false,
  }) : super(propertyName: propertyName) {
    if (titleText == null || titleText.isEmpty) {
      this.titleText = propertyName.toTitleCase();
    } else {
      this.titleText = titleText;
    }
  }

  final String? subtitleText;
  late final String? titleText;
}

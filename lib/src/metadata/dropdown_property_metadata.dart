import 'metadata.dart';

class DropdownPropertyMetadata extends PropertyMetadataBase {
  DropdownPropertyMetadata({
    required String propertyName,
    this.labelText,
    this.helperText,
    this.errorMaxLines,
    this.notSelectedValue,
    autoFocus = false,
  }) : super(propertyName: propertyName, autoFocus: autoFocus);

  final int? errorMaxLines;
  final String? helperText;
  final String? labelText;
  final dynamic notSelectedValue;
}

import 'package:flutter/material.dart';
import 'package:ocean/src/extensions/ocean_extensions.dart';
import 'metadata.dart';

class TextInputPropertyMetadata extends PropertyMetadataBase {
  TextInputPropertyMetadata({
    required String propertyName,
    required this.maximumLength,
    this.keyBoardType = TextInputType.text,
    String? labelText,
    this.helperText,
    this.hintText,
    this.errorMaxLines,
    autoFocus = false,
    this.enableAutoCorrect = false,
    this.enableSuggestions = false,
  }) : super(propertyName: propertyName, autoFocus: autoFocus) {
    if (labelText == null || labelText.isEmpty) {
      this.labelText = propertyName.toTitleCase();
    } else {
      this.labelText = labelText;
    }
  }

  final bool enableAutoCorrect;
  final bool enableSuggestions;
  final int? errorMaxLines;
  final String? helperText;
  final String? hintText;
  final TextInputType keyBoardType;
  late final String labelText;
  final int? maximumLength;
}

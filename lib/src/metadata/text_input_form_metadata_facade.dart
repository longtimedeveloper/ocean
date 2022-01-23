import 'package:flutter/material.dart';
import '../src.dart';

class TextInputFormMetadataFacade<T> extends FormMetadataFacadeBase<T, TextInputPropertyMetadata> {
  TextInputFormMetadataFacade(FormMetadataFacadeConfig<T> formMetadataFacadeConfig) : super(formMetadataFacadeConfig);

  bool get enableAutoCorrect {
    return propertyMetadata.enableAutoCorrect;
  }

  bool get enableSuggestions {
    return propertyMetadata.enableSuggestions;
  }

  int? get errorMaxLines {
    return propertyMetadata.errorMaxLines;
  }

  String? get helperText {
    return propertyMetadata.helperText;
  }

  String? get hintText {
    return propertyMetadata.hintText;
  }

  TextInputType get keyBoardType {
    return propertyMetadata.keyBoardType;
  }

  String get labelText {
    return propertyMetadata.labelText;
  }

  int? get maximumLength {
    return propertyMetadata.maximumLength;
  }
}

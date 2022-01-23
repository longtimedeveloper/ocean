import '../src.dart';

class DropdownFormMetadataFacade<T> extends FormMetadataFacadeBase<T, DropdownPropertyMetadata> {
  DropdownFormMetadataFacade(FormMetadataFacadeConfig<T> formMetadataFacadeConfig) : super(formMetadataFacadeConfig);

  int? get errorMaxLines {
    return propertyMetadata.errorMaxLines;
  }

  String? get helperText {
    return propertyMetadata.helperText;
  }

  String? get labelText {
    return propertyMetadata.labelText;
  }

  dynamic get notSelectedValue {
    return propertyMetadata.notSelectedValue;
  }
}

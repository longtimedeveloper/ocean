import '../src.dart';

class CheckboxFormMetadataFacade<T> extends FormMetadataFacadeBase<T, CheckboxPropertyMetadata> {
  CheckboxFormMetadataFacade(FormMetadataFacadeConfig<T> formMetadataFacadeConfig) : super(formMetadataFacadeConfig);

  String? get subtitleText {
    return propertyMetadata.subtitleText;
  }

  String? get titleText {
    return propertyMetadata.titleText;
  }
}

import '../src.dart';

class SliderFormMetadataFacade<T> extends FormMetadataFacadeBase<T, SliderPropertyMetadata> {
  SliderFormMetadataFacade(FormMetadataFacadeConfig<T> formMetadataFacadeConfig) : super(formMetadataFacadeConfig);

  bool get autoFocus {
    return propertyMetadata.autoFocus;
  }

  int? get divisions {
    return propertyMetadata.divisions;
  }

  double get max {
    return propertyMetadata.max;
  }

  double get min {
    return propertyMetadata.min;
  }
}

import 'package:ocean/src/metadata/metadata.dart';

import '../string_input/string_input.dart';
import '../validation/validation.dart';

abstract class BusinessObjectMetadataBuilderBase<T> {
  BusinessObjectMetadataBuilderBase();

  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper);

  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper);

  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper);

  void bootstrapType() {
    addSharedPropertyMetadata(PropertyMetadataManagerWrapper(SharedPropertyMetadataManager.instance.getManager(T)));
    addSharedValidationRules(ValidationRulesManagerWrapper(SharedValidationRulesManager.instance.getManager(T)));
    addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper(SharedStringFormatRulesManager.instance.getManager(T)));
  }
}

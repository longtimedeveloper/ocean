import 'metadata.dart';

class PropertyMetadataManagerWrapper {
  PropertyMetadataManagerWrapper(PropertyMetadataManager propertyMetadataManager) {
    _propertyMetadataManager = propertyMetadataManager;
  }

  late final PropertyMetadataManager _propertyMetadataManager;

  void addMetadata(PropertyMetadataBase propertyMetadataBase) {
    _propertyMetadataManager.addMetadata(propertyMetadataBase);
  }
}

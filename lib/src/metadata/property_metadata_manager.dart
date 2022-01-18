import '../src.dart';

class PropertyMetadataManager {
  PropertyMetadataManager();

  final Map<String, PropertyMetadataBase> _metadata = <String, PropertyMetadataBase>{};

  bool get hasMetadata {
    return _metadata.isNotEmpty;
  }

  Map<String, PropertyMetadataBase> get metadata {
    return _metadata;
  }

  void addMetadata(PropertyMetadataBase metadataBase) {
    if (metadataBase.propertyName.isEmpty) {
      throw OceanArgumentException(
        metadataBase.propertyName,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(metadataBase.propertyName),
      );
    }
    if (_metadata.containsKey(metadataBase.propertyName)) {
      throw OceanArgumentException(
        metadataBase.propertyName,
        MessageConstants.multiplePropertyMetadataNotAllowedFormat
            .formatString(_metadata[metadataBase.propertyName].runtimeType, metadataBase.propertyName),
      );
    }
    _metadata[metadataBase.propertyName] = metadataBase;
  }

  PropertyMetadataBase? getMetadataForProperty(String propertyName) {
    return _metadata[propertyName];
  }

  bool hasMetadataForProperty(String propertyName) {
    return _metadata[propertyName] != null;
  }
}

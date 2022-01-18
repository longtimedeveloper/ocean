import 'metadata.dart';

class SharedPropertyMetadataManager {
  SharedPropertyMetadataManager._();

  static SharedPropertyMetadataManager? _instance;

  final Map<Type, PropertyMetadataManager> _metadata = <Type, PropertyMetadataManager>{};

  static SharedPropertyMetadataManager get instance => _instance ??= SharedPropertyMetadataManager._();

  PropertyMetadataManager getManager(Type type) {
    var manager = _metadata[type];
    if (manager == null) {
      manager = PropertyMetadataManager();
      _metadata[type] = manager;
    }
    return manager;
  }
}

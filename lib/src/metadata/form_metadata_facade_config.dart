import '../src.dart';

class FormMetadataFacadeConfig<T> {
  const FormMetadataFacadeConfig({
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
  });

  final BusinessObjectBase businessObjectBase;
  final T Function() propertyGetter;
  final String propertyName;
  final void Function(T) propertySetter;
}

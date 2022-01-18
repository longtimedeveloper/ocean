import '../src.dart';

abstract class FormMetadataFacadeBase<T, TM> {
  FormMetadataFacadeBase(FormMetadataFacadeConfig<T> formMetadataFacadeConfig) {
    // this single parameter replaces the original four.
    // This was done becasuse GetIt container does not support object construction with more than two parameters
    _businessObjectBase = formMetadataFacadeConfig.businessObjectBase;
    _propertySetter = formMetadataFacadeConfig.propertySetter;
    _propertyGetter = formMetadataFacadeConfig.propertyGetter;
    propertyName = formMetadataFacadeConfig.propertyName;
    final propertyMetadataManager = SharedPropertyMetadataManager.instance.getManager(_businessObjectBase.runtimeType);

    final metadata = propertyMetadataManager.getMetadataForProperty(propertyName);
    if (metadata != null && metadata is TM) {
      _propertyMetadata = metadata as TM;
    } else {
      throw OceanException(MessageConstants.propertyMetadataNotFoundForPropertyFormat.formatString(propertyName));
    }
  }

  late final String propertyName;

  late final BusinessObjectBase _businessObjectBase;
  late final T Function() _propertyGetter;
  late final TM _propertyMetadata;
  late final void Function(T) _propertySetter;

  TM get propertyMetadata {
    return _propertyMetadata;
  }

  void addExternalValidationRuleBrokenRule(String ruleTypeName, String errorMessage) {
    _businessObjectBase.addExternalValidationRuleBrokenRule(propertyName, ruleTypeName, errorMessage);
  }

  void checkAllRules() {
    _businessObjectBase.checkAllRules();
  }

  void checkAllRulesForProperty(value) {
    _businessObjectBase.checkAllRulesForProperty(propertyName, value);
  }

  T getPropertyValue() {
    return _propertyGetter.call();
  }

  bool isValid() {
    return _businessObjectBase.isValid;
  }

  void removeExternalValidationRuleBrokenRule(String ruleTypeName) {
    _businessObjectBase.removeExternalValidationRuleBrokenRule(propertyName, ruleTypeName);
  }

  void setFormatedPropertyValue(dynamic value) {
    _businessObjectBase.endUIEditingModel(); // insurnace
    _propertySetter(value);
  }

  void setPropertyValue(dynamic value) {
    _businessObjectBase.beginUIEditingMode();
    _propertySetter(value);
    _businessObjectBase.endUIEditingModel();
  }

  String? validateProperty<PT>(PT? value) {
    return _businessObjectBase.checkAllRulesForProperty(propertyName, value);
  }
}

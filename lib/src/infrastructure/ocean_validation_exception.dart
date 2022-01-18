class OceanValidationException implements Exception {
  OceanValidationException(this.objectName, this.activeRuleSet, this.message, {this.propertyName = ''});

  final String activeRuleSet;
  final String message;
  final String objectName;
  final String propertyName;

  @override
  String toString() {
    if (propertyName.trim().isEmpty) {
      return '$runtimeType: Object: $objectName, Active Rule Set: $activeRuleSet, $message';
    }
    return '$runtimeType: Object: $objectName, Property Name: $propertyName, Active Rule Set: $activeRuleSet, $message';
  }
}

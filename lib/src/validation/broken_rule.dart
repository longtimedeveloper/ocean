class BrokenRule {
  BrokenRule(this.ruleTypeName, this.propertyName, this.errorMessage, {this.manuallyAdded = false});

  final String errorMessage;
  final bool manuallyAdded;
  final String propertyName;
  final String ruleTypeName;
}

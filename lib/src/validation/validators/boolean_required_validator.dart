import '../../src.dart';

/// Is associated with a bool property and when applied, requires that the value be true.
/// Used in websites to required users to accept terms, etc.
class BooleanRequiredValidator extends ValidatorBase {
  /// Constructor for [BooleanRequiredValidator].
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [ruleSet] is optional, defauls to an empty string.
  /// If the [ruleSet] is not specified, this validation rule will always be checked.
  /// If the [ruleSet] is specified, this rule will only be checked if it is contained in the [BusinessObjectBase.activeRuleSet].
  /// If this rule applies to more than one [ruleSet], then enter each [ruleSet] name separated by the pipe symbol.  Example:  [ruleSet] = "Insert|Update|Delete"
  ///
  /// [friendlyName] is optional, defaults to an empty string.
  /// When supplied, will be used in place of the [propertyName] in validation error messages.
  ///
  /// [additionalMessage] is optional, defaults to an empty string.
  /// When supplied, [additionalMessage] is appended to the boken rule message in the [BusinessObjectBase.createFailedValidationMessage] method.
  ///
  /// [overrideErrorMessage] is optional, defaults to an empty string.
  /// When supplied, [overrideErrorMessage] replaces the broken rule message in the  [BusinessObjectBase.createFailedValidationMessage] method.
  ///
  /// Throws [OceanArgumentException] if the propertyName is empty string.
  BooleanRequiredValidator(
    String propertyName, {
    String ruleSet = OceanStringCharacterConstants.stringEmpty,
    String friendlyName = OceanStringCharacterConstants.stringEmpty,
    String additionalMessage = OceanStringCharacterConstants.stringEmpty,
    String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
  }) : super(
          propertyName,
          ruleSet: ruleSet,
          friendlyName: friendlyName,
          additionalMessage: additionalMessage,
          overrideErrorMessage: overrideErrorMessage,
          allowMultiple: AllowMultiple.no,
          allowNullValue: AllowNullValue.no,
          requiredEntry: RequiredEntry.yes,
        );

  @override
  ValidateResult validate(value, businessObjectActiveRuleSet, {optionalValue}) {
    if (value != null && value is! bool) {
      throw OceanArgumentException(
        FieldNameConstants.value,
        MessageConstants.mustBeABoolTypeFormat.formatString(FieldNameConstants.value, value.runtimeType),
      );
    }

    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.businessObjectActiveRuleSet,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.businessObjectActiveRuleSet),
      );
    }

    if (super.skipValidation(businessObjectActiveRuleSet)) {
      return ValidateResult.success();
    }

    final displayName = super.resolvedDisplayName();

    if (value == null) {
      return super.createFailedValidateResult(MessageConstants.nullValueNotAllowedFormat.formatString(displayName));
    }

    final targetValue = value as bool;

    if (targetValue != true) {
      return super.createFailedValidateResult(MessageConstants.isRequiredToBeCheckedFormat.formatString(displayName));
    }

    return ValidateResult.success();
  }
}

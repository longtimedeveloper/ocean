import '../../src.dart';

/// Validator used to compare the target value to a lower and upper boundary to see if the value is within the specified range.
class RangeValidator extends ValidatorBase {
  /// Constructor for [RangeValidator].
  ///
  /// [propertyName] is required and is the property this validator is associated with.
  ///
  /// [lowerRangeBoundaryType] is a required field, and is used in the lower range value comparison.
  ///
  /// [lowerValue] is a required field, and is used in the lower range value comparison.
  ///
  /// [upperRangeBoundaryType] is a required field, and is used in the upper range value comparison.
  ///
  /// [upperValue] is a required field, and is used in the upper range value comparison.
  ///
  /// [requiredEntry] is optional, defaults to [RequiredEntry.yes].
  /// When [requiredEntry] is [RequiredEntry.no], if the value is empty, the validation will pass.
  /// When [requiredEntry] is [RequiredEntry.yes], if the value is empty or null, the validation will fail.
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
  /// [allowNullValue] is optional, defaults to [AllowNullValue.no].
  /// When [allowNullValue] is [AllowNullValue.no], if the value is null, the validation will fail.
  /// When [allowNullValue] is [AllowNullValue.yes], if the value is null, the validation will always pass.
  ///
  /// Throws [OceanArgumentException] if the propertyName is empty string.
  RangeValidator(
    String propertyName,
    this.lowerRangeBoundaryType,
    this.lowerValue,
    this.upperRangeBoundaryType,
    this.upperValue, {
    RequiredEntry requiredEntry = RequiredEntry.yes,
    String ruleSet = OceanStringCharacterConstants.stringEmpty,
    String friendlyName = OceanStringCharacterConstants.stringEmpty,
    String additionalMessage = OceanStringCharacterConstants.stringEmpty,
    String overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
    AllowNullValue allowNullValue = AllowNullValue.no,
  }) : super(
          propertyName,
          ruleSet: ruleSet,
          friendlyName: friendlyName,
          additionalMessage: additionalMessage,
          overrideErrorMessage: overrideErrorMessage,
          allowMultiple: AllowMultiple.no,
          allowNullValue: allowNullValue,
          requiredEntry: requiredEntry,
        );

  final RangeBoundaryType lowerRangeBoundaryType;
  final Comparable lowerValue;
  final RangeBoundaryType upperRangeBoundaryType;
  final Comparable upperValue;

  @override
  ValidateResult validate(value, String businessObjectActiveRuleSet, {optionalValue}) {
    if (businessObjectActiveRuleSet.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.businessObjectActiveRuleSet,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(
          FieldNameConstants.businessObjectActiveRuleSet,
        ),
      );
    }

    if (super.skipValidation(businessObjectActiveRuleSet)) {
      return ValidateResult.success();
    }

    if (value == null && allowNullValue == AllowNullValue.yes) {
      return ValidateResult.success();
    }

    final displayName = super.resolvedDisplayName();

    if (value == null && (allowNullValue == AllowNullValue.no || requiredEntry == RequiredEntry.yes)) {
      return super.createFailedValidateResult(MessageConstants.nullValueNotAllowedFormat.formatString(displayName));
    }

    if (value.runtimeType != lowerValue.runtimeType) {
      return super.createFailedValidateResult(
        MessageConstants.mustBeTheSameTypeFormat.formatString(
          displayName,
          value.runtimeType.toString(),
          lowerValue.runtimeType.toString(),
        ),
      );
    }

    if (value.runtimeType != upperValue.runtimeType) {
      return super.createFailedValidateResult(
        MessageConstants.mustBeTheSameTypeFormat.formatString(
          displayName,
          value.runtimeType.toString(),
          upperValue.runtimeType.toString(),
        ),
      );
    }

    switch (lowerRangeBoundaryType) {
      case RangeBoundaryType.inclusive:
        if (value < lowerValue) {
          return super.createFailedValidateResult(
            MessageConstants.mustBeGreaterThanOrEqualToFormat.formatString(displayName, lowerValue),
          );
        }
        break;
      case RangeBoundaryType.exclusive:
        if (value <= lowerValue) {
          return super.createFailedValidateResult(
            MessageConstants.mustBeGreaterThanFormat.formatString(displayName, lowerValue),
          );
        }
        break;
    }

    switch (upperRangeBoundaryType) {
      case RangeBoundaryType.inclusive:
        if (value > upperValue) {
          return super.createFailedValidateResult(
            MessageConstants.mustBeLessThanOrEqualToFormat.formatString(displayName, upperValue),
          );
        }
        break;
      case RangeBoundaryType.exclusive:
        if (value >= upperValue) {
          return super.createFailedValidateResult(
            MessageConstants.mustBeLessThanFormat.formatString(displayName, upperValue),
          );
        }

        break;
    }
    return ValidateResult.success();
  }
}

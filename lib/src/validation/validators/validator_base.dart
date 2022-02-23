import 'package:meta/meta.dart';
import '../../src.dart';

/// Base class for all Ocean validators.
abstract class ValidatorBase {
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
  /// [requiredEntry] is optional, defaults to [RequiredEntry.yes].
  /// When [requiredEntry] is [RequiredEntry.no], if the value is empty, the validation will pass.
  /// When [requiredEntry] is [RequiredEntry.yes], if the value is empty or null, the validation will fail.
  ///
  /// [allowNullValue] is optional, defaults to [AllowNullValue.no].
  /// When [allowNullValue] is [AllowNullValue.no], if the value is null, the validation will fail.
  /// When [allowNullValue] is [AllowNullValue.yes], if the value is null, the validation will always pass.
  ///
  /// When [optionalDataRequest] is not null, the [BusinessObjectBase] will use the data in the [OptionalDataRequest] object during validation.
  ///
  /// The primary use case is for the [ComparePropertyValidator.isValid] method that requires another property value for comparison.
  ///
  /// Throws [OceanArgumentException] if the propertyName is empty string.
  ValidatorBase(
    this.propertyName, {
    this.ruleSet = OceanStringCharacterConstants.stringEmpty,
    this.friendlyName = OceanStringCharacterConstants.stringEmpty,
    this.additionalMessage = OceanStringCharacterConstants.stringEmpty,
    this.overrideErrorMessage = OceanStringCharacterConstants.stringEmpty,
    this.allowMultiple = AllowMultiple.no,
    this.requiredEntry = RequiredEntry.yes,
    this.allowNullValue = AllowNullValue.no,
    this.optionalDataRequest,
  }) {
    if (propertyName.isEmpty) {
      throw OceanArgumentException(
        FieldNameConstants.propertyName,
        MessageConstants.stringArgumentIsRequiredButEmptyFormat.formatString(FieldNameConstants.propertyName),
      );
    }
  }

  /// Developers can specify an [additionalMessage] that is displayed when the [ValidatorBase] rule is broken.
  ///
  /// The [additionalMessage] is appended to the boken rule message in the [createFailedValidationMessage] method.
  final String additionalMessage;

  /// When [allowMultiple] is [AllowMultiple.no], this [ValidatorBase] rule can only be added to the [ValidationRulesManager] if this [propertyName] - [ValidatorBase] rule has not been previously added.
  ///
  /// When [allowMultiple] is [AllowMultiple.yes], mutiple [propertyName] - [ValidatorBase] can be added.
  /// While not a common scenario, this is possible in complex line of business applications when a property value needs to be validated against multiple other property values.
  /// Important - to allow multiple rules, all [ValidatorBase] rules must have [allowMultiple] set to [AllowMultiple.yes]; otherwise, an exception will be thrown.
  final AllowMultiple allowMultiple;

  /// When [allowNullValue] is [AllowNullValue.no], if the value is null, the validation will fail.
  ///
  /// When [allowNullValue] is [AllowNullValue.yes], if the value is null, the validation will always pass.
  final AllowNullValue allowNullValue;

  /// When the [friendlyName] is supplied, it overrides the [propertyName] displayed in failed validation messages.
  ///
  /// If not provided the [propertyName] will be reformatted by splitting the pascal case name, adding a white space between capitalized letters.
  final String friendlyName;

  /// When [optionalDataRequest] is not null, the [BusinessObjectBase] will use the data in the [OptionalDataRequest] object during validation.
  ///
  /// The primary use case is for the [ComparePropertyValidator.isValid] method that requires another property value for comparison.
  final OptionalDataRequest? optionalDataRequest;

  /// Developers can specify an [overrideErrorMessage] that is displayed when the super class [ValidatorBase] rule is broken.
  ///
  /// If supplied, [overrideErrorMessage] replaces the broken rule [finalErrorMessage].
  final String overrideErrorMessage;

  /// Name of the property this rule applies to.  Can not be an empty string.
  final String propertyName;

  /// When [requiredEntry] is [RequiredEntry.no], if the value is empty, the validation will pass.
  ///
  /// When [requiredEntry] is [RequiredEntry.yes], if the value is empty or null, the validation will fail.
  final RequiredEntry requiredEntry;

  /// If the [ruleSet] is not specified, this  super class [ValidatorBase] rule will always be checked.
  ///
  /// If the [ruleSet] is specified, then this  super class [ValidatorBase] rule will only be checked if it is contained in the  super class [BusinessObjectBase.activeRuleSet].
  ///
  /// If this  super class [ValidatorBase] rule applies to more than one [ruleSet], then enter each [ruleSet] name separated by the pipe symbol.  Example:  [ruleSet] = "Insert|Update|Delete"
  final String ruleSet;

  /// Protected method. Returns a [ValidateResult] with the [BrokenRule] populated.
  ///
  /// If the [overrideErrorMessage] has been set this will be returned, overriding the [validationErrorMessage] and [additionalMessage] values.
  ///
  /// If the [additionalMessage] has been set, this will be appended to the [validationErrorMessage] and returned.
  ///
  /// The [validationErrorMessage] is validation error text of the failed validation.
  @protected
  ValidateResult createFailedValidateResult(String validationErrorMessage) {
    var errorMessage = '';
    if (overrideErrorMessage.isNotEmpty) {
      errorMessage = overrideErrorMessage;
    } else if (additionalMessage.isNotEmpty) {
      errorMessage = '$validationErrorMessage $additionalMessage';
    } else {
      errorMessage = validationErrorMessage;
    }
    return ValidateResult(BrokenRule(runtimeType.toString(), propertyName, errorMessage));
  }

  /// Protected method. If [friendlyName] is supplied, it will be returned; otherwise the [propertyName] will be parsed and returned as title case.
  @protected
  String resolvedDisplayName() {
    if (friendlyName.isNotEmpty) {
      return friendlyName;
    }
    return propertyName.toTitleCase();
  }

  /// Protected method. Determines if this super class [ValidatorBase] rule should continue based on the [businessObjectActiveRuleSet] and [ruleSet] for this  super class [ValidatorBase] rule.
  ///
  /// If this [ruleSet] is empty, returns true.
  ///
  /// If this [ruleSet] contain the [businessObjectActiveRuleSet], returns true; otherwise, returns false;
  @protected
  bool skipValidation(String businessObjectActiveRuleSet) {
    // note: businessObjectActiveRuleSet should never be empty and other objects check for this and throw.
    if (businessObjectActiveRuleSet.isNotEmpty) {
      if (ruleSet.isEmpty) {
        return false;
      }
      if (ruleSet.contains(businessObjectActiveRuleSet)) {
        return false;
      }
    }
    return true;
  }

  /// When not valid, returns [ValidateResult] with the [BrokenRule] set; otherwise, returns [ValidateResult] with [ValidateResult.isValid] true.
  ///
  /// The [value] can be any null or not null type variable value.
  ///
  /// The [businessObjectActiveRuleSet] is the current [BusinessObjectBase.activeRuleSet] and can not be an empty string.
  /// The [optionalValue] is resolved at runtime as the [BusinessObjectBase] is checking each rule.  Some validators need to be passed additional data.
  ValidateResult validate(dynamic value, String businessObjectActiveRuleSet, {dynamic optionalValue});
}

import '../../src.dart';

mixin CompareValuesMixin {
  ValidateResult compare(
    ComparisionType comparisionType,
    String valueDisplayName,
    dynamic value,
    String otherValueDisplayName,
    dynamic otherValue,
    ValidateResult Function(String) createFailedValidateResult,
  ) {
    switch (comparisionType) {
      case ComparisionType.equal:
        if (value == otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
            MessageConstants.mustBeEqualToFormat.formatString(valueDisplayName, otherValueDisplayName),
          );
        }
      case ComparisionType.notEqual:
        if (value != otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
            MessageConstants.mustNotBeEqualToFormat.formatString(valueDisplayName, otherValueDisplayName),
          );
        }
      case ComparisionType.greaterThan:
        if (value > otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
              MessageConstants.mustBeGreaterThanFormat.formatString(valueDisplayName, otherValueDisplayName));
        }
      case ComparisionType.greaterThanEqual:
        if (value >= otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
              MessageConstants.mustBeGreaterThanOrEqualToFormat.formatString(valueDisplayName, otherValueDisplayName));
        }
      case ComparisionType.lessThan:
        if (value < otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
              MessageConstants.mustBeLessThanFormat.formatString(valueDisplayName, otherValueDisplayName));
        }
      case ComparisionType.lessThanEqual:
        if (value <= otherValue) {
          return ValidateResult.success();
        } else {
          return createFailedValidateResult(
              MessageConstants.mustBeLessThanOrEqualToFormat.formatString(valueDisplayName, otherValueDisplayName));
        }
    }
  }
}

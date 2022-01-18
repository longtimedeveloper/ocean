import 'validation.dart';

class ValidateResult {
  ValidateResult(this.brokenRule);

  ValidateResult.success() {
    brokenRule = null;
  }

  late final BrokenRule? brokenRule;

  bool get isNotValid {
    return !isValid;
  }

  bool get isValid {
    return brokenRule == null;
  }
}

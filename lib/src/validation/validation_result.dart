import 'dart:collection';
import 'validation.dart';

class ValidationResult {
  ValidationResult(List<Map<String, BrokenRule>> validationErrors) {
    _validationErrors = UnmodifiableListView(validationErrors);
    _isValid = validationErrors.isEmpty;
  }

  ValidationResult.success() {
    _validationErrors = UnmodifiableListView(<Map<String, BrokenRule>>[]);
    _isValid = true;
  }

  bool _isValid = false;
  late final UnmodifiableListView<Map<String, BrokenRule>> _validationErrors;

  bool get isValid {
    return _isValid;
  }

  UnmodifiableListView<Map<String, BrokenRule>> get validationErrors {
    return _validationErrors;
  }
}

import '../ocean_exportable_constants.dart';

class OptionalDataRequest {
  OptionalDataRequest.propertyValue(String propertyName) {
    _propertyName = propertyName;
  }

  String _propertyName = StringCharacterConstants.stringEmpty;

  String get propertyName {
    return _propertyName;
  }
}

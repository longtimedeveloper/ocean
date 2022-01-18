import 'package:ocean/src/src.dart';

class StringCasingCheck {
  StringCasingCheck({
    required this.lookFor,
    required this.replaceWith,
    this.stringCasingMethod = StringCasingMethod.stringSearch,
  }) {
    if (lookFor.length != replaceWith.length) {
      throw OceanArgumentException(
        FieldNameConstants.lookFor,
        MessageConstants.mustBeTheSameLengthFormat.formatString(FieldNameConstants.lookFor, FieldNameConstants.replaceWith),
      );
    }
  }

  final String lookFor;
  final String replaceWith;
  final StringCasingMethod stringCasingMethod;
}

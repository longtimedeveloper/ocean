import 'package:ocean/src/src.dart';

class StringCasingCheck extends Comparable<StringCasingCheck> {
  StringCasingCheck({
    required this.id,
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

  factory StringCasingCheck.fromJson(Map<String, dynamic> json) {
    var stringCasingMethod = StringCasingMethod.stringSearch;
    final stringCasingMethodString = json[stringCasingMethodPropertyName];

    if (stringCasingMethodString != null && stringCasingMethodString is String) {
      if (stringCasingMethodString == 'regEx') {
        stringCasingMethod = StringCasingMethod.regEx;
      }
    }
    return StringCasingCheck(
      id: json[idPropertyName] as String,
      lookFor: json[lookForPropertyName] as String,
      replaceWith: json[replaceWithPropertyName] as String,
      stringCasingMethod: stringCasingMethod,
    );
  }

  /// Provides, lookFor
  static const String idPropertyName = 'id';

  /// Provides, lookFor
  static const String lookForPropertyName = 'lookFor';

  /// Provides, replaceWith
  static const String replaceWithPropertyName = 'replaceWith';

  /// Provides, stringCasingMethod
  static const String stringCasingMethodPropertyName = 'stringCasingMethod';

  final String id;
  final String lookFor;
  final String replaceWith;
  final StringCasingMethod stringCasingMethod;

  @override
  int compareTo(StringCasingCheck other) {
    return lookFor.compareTo(other.lookFor);
  }

  Map<String, dynamic> toJson() => {
        idPropertyName: id,
        lookForPropertyName: lookFor,
        replaceWithPropertyName: replaceWith,
        stringCasingMethodPropertyName: stringCasingMethod.toString().replaceFirst('StringCasingMethod.', ''),
      };
}

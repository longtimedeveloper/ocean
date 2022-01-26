import '../src.dart';

String _convertToTitleCase(String text) {
  if (text.length <= 1) {
    return text.toUpperCase();
  }

  final beforeCapitalLetter = RegExp(RegExPatternConstants.capitalLetter);
  final parts = text.split(beforeCapitalLetter);

  if (parts.isNotEmpty) {
    final firstLetter = parts[0].substring(0, 1).toUpperCase();
    final String remainingLetters = parts[0].substring(1);
    parts[0] = '$firstLetter$remainingLetters';
  }
  return parts.join(StringCharacterConstants.singleSpace);
}

extension CapitalizedStringExtension on String {
  String toTitleCase() {
    return _convertToTitleCase(this);
  }
}

int _countOf(String value, String pattern) {
  final r = RegExp(pattern);
  final result = r.allMatches(value).length;
  return result;
}

extension RemoveLastCharacters on String {
  String removeLastCharacter() {
    return removeLastCharacters(1);
  }

  String removeLastCharacters(int countToRemove) {
    final input = this;
    if (input.length >= countToRemove) {
      return substring(0, input.length - countToRemove);
    }
    return input;
  }
}

extension StringContains on String {
  int countOfUpperCaseLetters() {
    return _countOf(this, RegExPatternConstants.upperCaseLetters);
  }

  int countOfLowerCaseLetters() {
    return _countOf(this, RegExPatternConstants.lowerCaseLetters);
  }

  int countOfDigits() {
    return _countOf(this, RegExPatternConstants.digits);
  }

  int countOfSpecialCharacters(List<String> allowedSpecialCharacters) {
    var count = 0;
    final input = this;
    for (var character in allowedSpecialCharacters) {
      if (input.contains(character)) {
        count += 1;
      }
    }
    return count;
  }
}

String _formatString(String text, dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4) {
  var result = text;
  if (arg0 != null) {
    result = result.replaceAll('{0}', arg0.toString());
  }
  if (arg1 != null) {
    result = result.replaceAll('{1}', arg1.toString());
  }
  if (arg2 != null) {
    result = result.replaceAll('{2}', arg2.toString());
  }
  if (arg3 != null) {
    result = result.replaceAll('{3}', arg3.toString());
  }
  if (arg4 != null) {
    result = result.replaceAll('{4}', arg4.toString());
  }
  return result;
}

extension StringFormatExtension on String {
  String formatString(dynamic arg0, [dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4]) {
    return _formatString(this, arg0, arg1, arg2, arg3, arg4);
  }
}

extension StringIsAExtension on String {
  bool isSingleLetterCharacter() {
    final c = this;
    if (c.length != 1) {
      throw OceanException(MessageConstants.lengthMustBeOne);
    }

    final r = RegExp(RegExPatternConstants.upperAndLowerCaseLetters);
    return r.hasMatch(this);
  }

  bool isSingleDigitCharacter() {
    final c = this;
    if (c.length != 1) {
      throw OceanException(MessageConstants.lengthMustBeOne);
    }

    final r = RegExp(RegExPatternConstants.digits);
    return r.hasMatch(this);
  }

  bool isAllDigits() {
    final r = RegExp(RegExPatternConstants.digitsOnly);
    return r.hasMatch(this);
  }
}

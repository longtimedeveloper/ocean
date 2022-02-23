import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ocean/ocean.dart';
import '../src.dart';

class FormatText {
  FormatText._();

  static FormatText? _instance;

  final UnmodifiableListView<StringCasingCheck> _stringCasingChecks =
      SharedStringCasingChecks.instance.getStringCasingChecks;

  static FormatText get instance => _instance ??= FormatText._();

  String applyStringFormat(StringFormatRule stringFormatRule, String value) {
    value = value.trim();
    if (value.isEmpty) {
      return value;
    }

    value = _applySpaceRemoval(stringFormatRule.removeSpace, value);

    switch (stringFormatRule.stringCase) {
      case StringCase.none:
        return value;
      case StringCase.lower:
        return value.toLowerCase();
      case StringCase.upper:
        return value.toUpperCase();
      case StringCase.proper:
        return _formatProper(value);
      case StringCase.phoneWithParentheses:
      case StringCase.phoneWithParenthesesProper:
      case StringCase.phoneWithParenthesesLower:
      case StringCase.phoneWithParenthesesUpper:
      case StringCase.phoneWithDashes:
      case StringCase.phoneWithDashesProper:
      case StringCase.phoneWithDashesLower:
      case StringCase.phoneWithDashesUpper:
      case StringCase.phoneWithDots:
      case StringCase.phoneWithDotsProper:
      case StringCase.phoneWithDotsLower:
      case StringCase.phoneWithDotsUpper:
        return _formatPhone(value, stringFormatRule.stringCase, stringFormatRule.phoneExtension);
      case StringCase.sentenance:
        return _toSentenceCase(value);
    }
  }

  String _applySpaceRemoval(RemoveSpace removeSpace, String value) {
    switch (removeSpace) {
      case RemoveSpace.none:
        return value;
      case RemoveSpace.multipleSpaces:
        return value.replaceAll(RegExp(OceanRegExPatternConstants.spaces), OceanStringCharacterConstants.singleSpace);
      case RemoveSpace.allSpaces:
        return value.replaceAll(RegExp(OceanRegExPatternConstants.spaces), OceanStringCharacterConstants.stringEmpty);
    }
  }

  String _applyStringCasingChecks(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return value;
    }

    value += OceanStringCharacterConstants.singleSpace;
    for (var check in _stringCasingChecks) {
      switch (check.stringCasingMethod) {
        case StringCasingMethod.stringSearch:
          if (value.contains(check.lookFor)) {
            value = value.replaceAll(check.lookFor, check.replaceWith);
          }
          break;
        case StringCasingMethod.regEx:
          var pattern = '${check.lookFor}${OceanRegExPatternConstants.letters}';
          var allMatches = RegExp(pattern).allMatches(value);
          var regExTemp = value;
          for (var match in allMatches) {
            var target = value.substring(match.start, match.end);
            var lookForLength = check.lookFor.length;
            regExTemp = regExTemp.replaceRange(match.start + lookForLength, match.start + lookForLength + 1,
                target.substring(lookForLength, lookForLength + 1).toUpperCase());
          }
          value = regExTemp;
          break;
      }
    }
    return value.trim();
  }

  String _formatExtension(StringCase stringCasing, String value) {
    final stringCase = stringCasing.name.toLowerCase();
    if (stringCase.contains(OceanStringWordConstants.proper)) {
      return _formatProper(value);
    } else if (stringCase.contains(OceanStringWordConstants.upper)) {
      return value.toUpperCase();
    } else if (stringCase.contains(OceanStringWordConstants.lower)) {
      return value.toLowerCase();
    } else {
      return value;
    }
  }

  String _formatPhone(String value, StringCase stringCasing, PhoneExtension phoneExtension) {
    value = value.trim();
    if (value.isEmpty || value.length < 10) {
      return value;
    }

    String tempCasted = value + OceanStringCharacterConstants.singleSpace;

    try {
      int intX = tempCasted.indexOf(OceanStringCharacterConstants.singleSpace, 9);
      if (intX > -1) {
        String temp = value.substring(0, intX);
        temp = temp.replaceAll('(', OceanStringCharacterConstants.stringEmpty);
        temp = temp.replaceAll(')', OceanStringCharacterConstants.stringEmpty);
        temp = temp.replaceAll(' ', OceanStringCharacterConstants.stringEmpty);
        temp = temp.replaceAll('-', OceanStringCharacterConstants.stringEmpty);
        temp = temp.replaceAll('.', OceanStringCharacterConstants.stringEmpty);

        String characterCaseName = stringCasing.name;
        String extension = OceanStringCharacterConstants.stringEmpty;

        BigInt? bigTemp = BigInt.tryParse(temp);
        if (bigTemp != null) {
          if (phoneExtension == PhoneExtension.keep) {
            extension = tempCasted.substring(intX).trim();
          }
          if (characterCaseName.contains('Dots')) {
            var formatter = MaskTextInputFormatter(mask: '###.###.####');
            tempCasted = formatter.maskText(bigTemp.toString());
          } else if (characterCaseName.contains('Dashes')) {
            var formatter = MaskTextInputFormatter(mask: '###-###-####');
            tempCasted = formatter.maskText(bigTemp.toString());
          } else {
            var formatter = MaskTextInputFormatter(mask: '(###) ###-####');
            tempCasted = formatter.maskText(bigTemp.toString());
          }
          if (phoneExtension == PhoneExtension.keep && extension.isNotEmpty) {
            tempCasted = tempCasted + OceanStringCharacterConstants.doubleSpace + _formatExtension(stringCasing, extension);
          }
        }
      }
    } finally {}
    return tempCasted.trim();
  }

  String _formatProper(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return value;
    }

    value = value.toLowerCase();
    final List<String> words = value.split(OceanStringCharacterConstants.singleSpace);
    for (int i = 0; i < words.length; i++) {
      words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
    }
    final output = words.join(OceanStringCharacterConstants.singleSpace);
    return _applyStringCasingChecks(output);
  }

  String _toSentenceCase(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return value;
    }

    var temp = value.toLowerCase();
    if (temp.endsWith('.')) {
      temp = temp + OceanStringCharacterConstants.singleSpace;
    }
    var sentences = temp.split('. ');
    var finalSentences = [];
    for (var item in sentences) {
      finalSentences.add(toBeginningOfSentenceCase(item)!.trim());
    }
    return finalSentences.join('. ').trimRight();
  }
}

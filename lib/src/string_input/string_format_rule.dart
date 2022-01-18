import 'string_input.dart';
import '../string_casing/string_casing.dart';

class StringFormatRule {
  StringFormatRule({
    required this.stringCase,
    this.removeSpace = RemoveSpace.multipleSpaces,
    this.phoneExtension = PhoneExtension.keep,
  });

  final PhoneExtension phoneExtension;
  final RemoveSpace removeSpace;
  final StringCase stringCase;
}

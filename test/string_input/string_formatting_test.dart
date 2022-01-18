import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('Tests for String Formatting', () {
    setUp(() {
      SharedStringCasingChecks.instance.loadDefaultChecks();
    });

    test('Format Test Use Cases', () {
      void testRunner(StringCase stringCasing, String value, String expected,
          {RemoveSpace removeSpace = RemoveSpace.multipleSpaces}) {
        // arrange
        final stringFormatRule =
            StringFormatRule(stringCase: stringCasing, removeSpace: removeSpace, phoneExtension: PhoneExtension.keep);
        // act
        final result = FormatText.instance.applyStringFormat(stringFormatRule, value);
        // assert
        expect(result, expected);
      }

      testRunner(StringCase.sentenance, '', '');
      testRunner(StringCase.sentenance, 'HELLO THERE.', 'Hello there.');
      testRunner(StringCase.upper, 'test', 'TEST');
      testRunner(StringCase.proper, 'dart wpf .net', 'Dart WPF .NET');
      testRunner(StringCase.proper, 'dart macmalley mcjones wpf o\'grady', 'Dart MacMalley McJones WPF O\'Grady');
      testRunner(StringCase.phoneWithDashes, '5555551212', '555-555-1212');
      testRunner(StringCase.phoneWithDots, '5555551212', '555.555.1212');
      testRunner(StringCase.phoneWithParentheses, '5555551212', '(555) 555-1212');
      testRunner(StringCase.phoneWithDashesProper, '5555551212  ext 202', '555-555-1212  Ext 202');
      testRunner(StringCase.phoneWithDotsProper, '5555551212   ext 202', '555.555.1212  Ext 202');
      testRunner(StringCase.phoneWithDotsLower, '5555551212   ext 202', '555.555.1212  ext 202');
      testRunner(StringCase.phoneWithDotsUpper, '5555551212   ext 202', '555.555.1212  EXT 202');
      testRunner(StringCase.phoneWithParentheses, '5555551212  ext 202', '(555) 555-1212  ext 202');
      testRunner(StringCase.upper, 'te s  t ', 'TEST', removeSpace: RemoveSpace.allSpaces);
    });
  });
}

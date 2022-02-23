import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('Ocean Extensions', () {
    test('toTitleCase', () {
      expect('dart'.toTitleCase(), 'Dart');
      expect('k'.toTitleCase(), 'K');
    });

    test('countOfUpperCaseLetters', () {
      expect('ABcD'.countOfUpperCaseLetters(), 3);
      expect('A'.countOfUpperCaseLetters(), 1);
      expect('cdadd'.countOfUpperCaseLetters(), 0);
    });

    test('countOfUpperCaseLetters', () {
      expect('ABcD'.countOfLowerCaseLetters(), 1);
      expect('A'.countOfLowerCaseLetters(), 0);
      expect('cdadd'.countOfLowerCaseLetters(), 5);
    });

    test('countOfDigits', () {
      expect('ABcD'.countOfDigits(), 0);
      expect('1'.countOfDigits(), 1);
      expect('cd2a6dd'.countOfDigits(), 2);
    });

    List<String> allowedSpecialCharactersList = <String>[];
    for (var i = 0; i < OceanStringWordConstants.defaultSpecialCharacters.length; i++) {
      allowedSpecialCharactersList.add(OceanStringWordConstants.defaultSpecialCharacters[i]);
    }

    test('countOfSpecialCharacters', () {
      expect('ABcD'.countOfSpecialCharacters(allowedSpecialCharactersList), 0);
      expect('A!326\$'.countOfSpecialCharacters(allowedSpecialCharactersList), 2);
      expect('cd()+add'.countOfSpecialCharacters(allowedSpecialCharactersList), 3);
    });

    test('formatString', () {
      expect('hello one {0}'.formatString('1'), 'hello one 1');
      expect('hello two {0} {1}'.formatString('1', '2'), 'hello two 1 2');
      expect('hello three {0} {1} {2}'.formatString('1', '2', '3'), 'hello three 1 2 3');
      expect('hello four {0} {1} {2} {3}'.formatString('1', '2', '3', '4'), 'hello four 1 2 3 4');
      expect('hello five {0} {1} {2} {3} {4}'.formatString('1', '2', '3', '4', '5'), 'hello five 1 2 3 4 5');
    });

    test('isSingleLetterCharacter', () {
      expect(() => ''.isSingleLetterCharacter(), throwsA(const TypeMatcher<OceanException>()));
      expect(() => '  '.isSingleLetterCharacter(), throwsA(const TypeMatcher<OceanException>()));
      expect('1'.isSingleLetterCharacter(), false);
      expect('A'.isSingleLetterCharacter(), true);
      expect('B'.isSingleLetterCharacter(), true);
    });

    test('isSingleDigitCharacter', () {
      expect(() => ''.isSingleDigitCharacter(), throwsA(const TypeMatcher<OceanException>()));
      expect(() => '  '.isSingleDigitCharacter(), throwsA(const TypeMatcher<OceanException>()));
      expect('1'.isSingleDigitCharacter(), true);
      expect('B'.isSingleDigitCharacter(), false);
    });

    test('isAllDigits', () {
      expect('1'.isAllDigits(), true);
      expect('0195'.isAllDigits(), true);
      expect('B'.isAllDigits(), false);
      expect('123B'.isAllDigits(), false);
    });

    test('RemoveLastCharacters', () {
      // arrange
      const sut = 'flutter';

      // act

      // assert
      expect(sut.removeLastCharacters(20), sut);
      expect(sut.removeLastCharacters(2), 'flutt');
      expect(sut.removeLastCharacter(), 'flutte');
    });
  });
}

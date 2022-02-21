import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('StringCasingCheck throws when lookFor and replaceWith lengths are different', () {
    expect(() => StringCasingCheck(id: 'dummy', lookFor: 'a', replaceWith: 'aa'),
        throwsA(const TypeMatcher<OceanArgumentException>()));
  });

  test('StringCasingCheck.fromJson works without stringCasingMethod', () {
    // arrange
    const jsonText = '{"id" : "dummy","lookFor": " And ","replaceWith": " and "}';

    // act
    final result = StringCasingCheck.fromJson(json.decode(jsonText));

    // assert
    expect(result.id, 'dummy');
    expect(result.stringCasingMethod, StringCasingMethod.stringSearch);
  });

  test('StringCasingCheck.fromJson works with stringCasingMethod', () {
    // arrange
    const jsonText = '{"id" : "dummy","lookFor": " And ","replaceWith": " and ", "stringCasingMethod":"regEx"}';

    // act
    final result = StringCasingCheck.fromJson(json.decode(jsonText));

    // assert
    expect(result.id, 'dummy');
    expect(result.stringCasingMethod, StringCasingMethod.regEx);
  });

  test('StringCasingCheck.toJson works', () {
    // arrange
    final sut = StringCasingCheck(id: 'dummy', lookFor: 'Lookfor', replaceWith: 'LookFor');

    // act
    final result = sut.toJson().toString();

    // assert
    expect(result, '{id: dummy, lookFor: Lookfor, replaceWith: LookFor, stringCasingMethod: stringSearch}');
  });

  test('List of StringCasingCheck sort correctly', () {
    // arrange
    final checks = <StringCasingCheck>[];
    checks.add(StringCasingCheck(id: 'dummy', lookFor: 'Dbc', replaceWith: 'DBC'));
    checks.add(StringCasingCheck(id: 'dummy', lookFor: 'Abc', replaceWith: 'ABC'));

    // act
    checks.sort();

    // assert
    expect(checks[0].lookFor, 'Abc');
  });
}

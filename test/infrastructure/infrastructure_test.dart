import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('KeyValuePair creation', () {
    // arrange
    final sut = KeyValuePair('key', 'value');

    // act

    // assert
    expect(sut.key, 'key');
    expect(sut.value, 'value');
  });

  test('OceanArgumentException creation', () {
    // arrange
    final sut = OceanArgumentException('arg', 'msg');

    // act

    // assert
    expect(sut.toString(), 'OceanArgumentException: Argument: arg, msg');
  });

  test('OceanException creation', () {
    // arrange
    final sut = OceanException('msg');

    // act

    // assert
    expect(sut.toString(), 'OceanException: msg');
  });

  test('OceanValidationException creation without propertyname', () {
    // arrange
    final sut = OceanValidationException('customer', 'insert', 'msg');

    // act

    // assert
    expect(sut.toString(), 'OceanValidationException: Object: customer, Active Rule Set: insert, msg');
  });

  test('OceanValidationException creation with propertyname', () {
    // arrange
    final sut = OceanValidationException('customer', 'insert', 'msg', propertyName: 'firstName');

    // act

    // assert
    expect(sut.toString(),
        'OceanValidationException: Object: customer, Property Name: firstName, Active Rule Set: insert, msg');
  });
}

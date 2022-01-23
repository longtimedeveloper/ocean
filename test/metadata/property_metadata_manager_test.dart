import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  test('PropertyMetadataManager empty', () {
    // arrange
    final sut = PropertyMetadataManager();

    // act

    // assert
    expect(sut.hasMetadata, false);
    expect(sut.metadata, {});
    expect(sut.hasMetadataForProperty('propertyName'), false);
    expect(sut.getMetadataForProperty('propertyName'), null);
  });

  test('PropertyMetadataManager normal', () {
    // arrange
    final sut = PropertyMetadataManager();

    // act
    sut.addMetadata(TextInputPropertyMetadata(propertyName: 'firstName', maximumLength: 25));
    sut.addMetadata(TextInputPropertyMetadata(
      propertyName: 'lastName',
      maximumLength: 25,
      labelText: 'Last Name(s)',
      helperText: 'Help',
      errorMaxLines: 5,
      hintText: 'Hint',
      keyBoardType: TextInputType.name,
    ));
    final TextInputPropertyMetadata? fnResult = sut.getMetadataForProperty('firstName') as TextInputPropertyMetadata?;
    final TextInputPropertyMetadata? lnResult = sut.getMetadataForProperty('lastName') as TextInputPropertyMetadata?;

    // assert
    expect(sut.hasMetadata, true);
    expect(sut.hasMetadataForProperty('firstName'), true);

    expect(fnResult != null, true);
    expect(fnResult!.propertyName, 'firstName');
    expect(fnResult.labelText, 'First Name');
    expect(fnResult.helperText, null);
    expect(fnResult.errorMaxLines, null);
    expect(fnResult.hintText, null);
    expect(fnResult.keyBoardType, TextInputType.text);

    // assert
    expect(sut.hasMetadataForProperty('lastName'), true);
    expect(lnResult != null, true);
    expect(lnResult!.propertyName, 'lastName');
    expect(lnResult.labelText, 'Last Name(s)');
    expect(lnResult.helperText, 'Help');
    expect(lnResult.errorMaxLines, 5);
    expect(lnResult.hintText, 'Hint');
    expect(lnResult.keyBoardType, TextInputType.name);
  });

  test('PropertyMetadataManager propertyName empty throws', () {
    // arrange
    final sut = PropertyMetadataManager();

    // act

    // assert
    expect(() => sut.addMetadata(TextInputPropertyMetadata(propertyName: '', maximumLength: null)),
        throwsA(const TypeMatcher<OceanArgumentException>()));
  });

  test('PropertyMetadataManager adding duplicate throws', () {
    // arrange
    final sut = PropertyMetadataManager();

    // act
    sut.addMetadata(TextInputPropertyMetadata(propertyName: 'firstName', maximumLength: 25));

    // assert
    expect(() => sut.addMetadata(TextInputPropertyMetadata(propertyName: 'firstName', maximumLength: 25)),
        throwsA(const TypeMatcher<OceanArgumentException>()));
  });
}

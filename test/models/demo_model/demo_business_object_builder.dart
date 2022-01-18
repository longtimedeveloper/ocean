import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'demo.dart';
import '../../test_constants.dart';

class DemoBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<Demo> {
  DemoBusinessObjectBuilder();

  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Demo.cellPhonePropertyName,
        maximumLength: Demo.cellPhoneMaximumLength,
        keyBoardType: TextInputType.phone,
        helperText: 'No extension, just number.'));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Demo.emailPropertyName,
        maximumLength: Demo.emailMaximumLength,
        keyBoardType: TextInputType.emailAddress));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Demo.firstNamePropertyName,
        maximumLength: Demo.firstNameMaximumLength,
        keyBoardType: TextInputType.name));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Demo.lastNamePropertyName,
        maximumLength: Demo.lastNameMaximumLength,
        keyBoardType: TextInputType.name));
    wrapper.addMetadata(
        TextInputPropertyMetadata(propertyName: Demo.passwordPropertyName, maximumLength: Demo.passwordMaximumLength));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Demo.phonePropertyName,
        maximumLength: Demo.phoneMaximumLength,
        helperText: 'Phone and extension OK.'));
    wrapper.addMetadata(
        TextInputPropertyMetadata(propertyName: Demo.userNamePropertyName, maximumLength: Demo.userNameMaximumLength));
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {
    wrapper.addRule(Demo.cellPhonePropertyName,
        StringFormatRule(stringCase: StringCase.phoneWithDashes, phoneExtension: PhoneExtension.remove));
    wrapper.addRule(Demo.emailPropertyName, StringFormatRule(stringCase: StringCase.lower));
    wrapper.addRule(Demo.firstNamePropertyName, StringFormatRule(stringCase: StringCase.proper));
    wrapper.addRule(Demo.lastNamePropertyName, StringFormatRule(stringCase: StringCase.proper));
    wrapper.addRule(Demo.phonePropertyName,
        StringFormatRule(stringCase: StringCase.phoneWithDashesProper, phoneExtension: PhoneExtension.keep));

    // not required
    //   password
    //   userName
  }

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper.addRule(StringLengthValidator.maximumOnly(Demo.cellPhonePropertyName, Demo.cellPhoneMaximumLength));
    wrapper.addRule(
        StringLengthValidator(Demo.firstNamePropertyName, Demo.firstNameMinimumLength, Demo.firstNameMaximumLength));
    wrapper.addRule(RegularExpressionValidator(Demo.emailPropertyName, RegularExpressionPatternType.email));
    wrapper
        .addRule(StringLengthValidator(Demo.lastNamePropertyName, Demo.lastNameMinimumLength, Demo.lastNameMaximumLength));
    wrapper
        .addRule(ComparePropertyValidator(Demo.lastNamePropertyName, Demo.firstNamePropertyName, ComparisionType.notEqual));
    wrapper.addRule(PasswordValidator(Demo.passwordPropertyName, Demo.passwordMinimumLength, Demo.passwordMaximumLength,
        StringConstants.allowedSpecialCharacters));
    wrapper.addRule(StringLengthValidator(Demo.phonePropertyName, Demo.phoneMinimumLength, Demo.phoneMaximumLength));
    wrapper
        .addRule(StringLengthValidator(Demo.userNamePropertyName, Demo.userNameMinimumLength, Demo.userNameMaximumLength));
  }
}

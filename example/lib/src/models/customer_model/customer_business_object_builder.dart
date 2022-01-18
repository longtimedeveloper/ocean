import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'customer.dart';

class DemoBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<Customer> {
  DemoBusinessObjectBuilder();

  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Customer.cellPhonePropertyName,
        maximumLength: Customer.cellPhoneMaximumLength,
        keyBoardType: TextInputType.phone,
        helperText: 'No extension, just number. Not required.'));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Customer.emailPropertyName,
        maximumLength: Customer.emailMaximumLength,
        keyBoardType: TextInputType.emailAddress));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Customer.firstNamePropertyName,
        maximumLength: Customer.firstNameMaximumLength,
        keyBoardType: TextInputType.name,
        helperText: '1-Exception See Console, 2-Warning, 3-Minor error'));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Customer.lastNamePropertyName,
        maximumLength: Customer.lastNameMaximumLength,
        keyBoardType: TextInputType.name));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: Customer.phonePropertyName,
        maximumLength: Customer.phoneMaximumLength,
        helperText: 'Phone and extension OK.'));
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {
    wrapper.addRule(Customer.cellPhonePropertyName,
        StringFormatRule(stringCase: StringCase.phoneWithDashes, phoneExtension: PhoneExtension.remove));
    wrapper.addRule(Customer.emailPropertyName, StringFormatRule(stringCase: StringCase.lower));
    wrapper.addRule(Customer.firstNamePropertyName, StringFormatRule(stringCase: StringCase.proper));
    wrapper.addRule(Customer.lastNamePropertyName, StringFormatRule(stringCase: StringCase.proper));
    wrapper.addRule(Customer.phonePropertyName, StringFormatRule(stringCase: StringCase.phoneWithDashesProper));

    // not required
    //   password
    //   userName
  }

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper.addRule(RegularExpressionValidator(Customer.cellPhonePropertyName, RegularExpressionPatternType.usPhoneNumber,
        requiredEntry: RequiredEntry.no));
    wrapper.addRule(StringLengthValidator(
        Customer.firstNamePropertyName, Customer.firstNameMinimumLength, Customer.firstNameMaximumLength));
    wrapper.addRule(RegularExpressionValidator(Customer.emailPropertyName, RegularExpressionPatternType.email));
    wrapper.addRule(StringLengthValidator(
        Customer.lastNamePropertyName, Customer.lastNameMinimumLength, Customer.lastNameMaximumLength));
    wrapper.addRule(
        ComparePropertyValidator(Customer.lastNamePropertyName, Customer.firstNamePropertyName, ComparisionType.notEqual));
    wrapper.addRule(
        StringLengthValidator(Customer.phonePropertyName, Customer.phoneMinimumLength, Customer.phoneMaximumLength));
  }
}

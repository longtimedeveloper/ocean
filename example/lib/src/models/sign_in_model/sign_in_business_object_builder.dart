import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'sign_in.dart';

class SignInBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<SignIn> {
  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: SignIn.emailPropertyName,
        maximumLength: SignIn.emailMaximumLength,
        keyBoardType: TextInputType.emailAddress));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: SignIn.passwordPropertyName,
        maximumLength: SignIn.passwordMaximumLength,
        keyBoardType: TextInputType.visiblePassword,
        helperText: 'Enter:  p  to show invalid credentials'));
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {
    wrapper.addRule(SignIn.emailPropertyName, StringFormatRule(stringCase: StringCase.lower));
  }

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper.addRule(RegularExpressionValidator(SignIn.emailPropertyName, RegularExpressionPatternType.email));
    wrapper.addRule(StringLengthValidator.maximumOnly(SignIn.emailPropertyName, SignIn.emailMaximumLength));
    wrapper.addRule(
        StringLengthValidator(SignIn.passwordPropertyName, SignIn.passwordMinimumLength, SignIn.passwordMaximumLength));
  }
}

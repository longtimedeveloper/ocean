import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';
import 'user_registration.dart';
import '../../example_constants.dart';

class UserRegistrationBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<UserRegistration> {
  UserRegistrationBusinessObjectBuilder();

  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(CheckboxPropertyMetadata(
        propertyName: UserRegistration.acknowledgeTermsPropertyName, titleText: 'Acknowledge Terms and Conditions'));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: UserRegistration.passwordPropertyName,
        maximumLength: UserRegistration.passwordMaximumLength,
        keyBoardType: TextInputType.visiblePassword));
    wrapper.addMetadata(TextInputPropertyMetadata(
        propertyName: UserRegistration.userNamePropertyName, maximumLength: UserRegistration.userNameMaximumLength));
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {}

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper
        .addRule(BooleanRequiredValidator(UserRegistration.acknowledgeTermsPropertyName, overrideErrorMessage: 'Required'));
    wrapper.addRule(PasswordValidator(UserRegistration.passwordPropertyName, UserRegistration.passwordMinimumLength,
        UserRegistration.passwordMaximumLength, StringConstants.allowedSpecialCharacters));
    wrapper.addRule(StringLengthValidator(UserRegistration.userNamePropertyName, UserRegistration.userNameMinimumLength,
        UserRegistration.userNameMaximumLength));
  }
}

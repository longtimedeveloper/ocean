import 'package:ocean/ocean.dart';
import 'user_options.dart';

class UserOptionsBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<UserOptions> {
  UserOptionsBusinessObjectBuilder();

  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(CheckboxPropertyMetadata(
        propertyName: UserOptions.acknowledgeTermsPropertyName,
        titleText: 'Acknowledge Terms and Conditions',
        autoFocus: true));
    wrapper.addMetadata(CheckboxPropertyMetadata(
        propertyName: UserOptions.acknowledgeClubTermsPropertyName, titleText: 'Acknowledge Club Terms'));
    wrapper.addMetadata(CheckboxPropertyMetadata(
        propertyName: UserOptions.joinClubPropertyName, titleText: 'Join Club', subtitleText: 'Club is fun!'));
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {}

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper.addRule(BooleanRequiredValidator(UserOptions.acknowledgeTermsPropertyName, overrideErrorMessage: 'Required'));
    wrapper
        .addRule(BooleanRequiredValidator(UserOptions.acknowledgeClubTermsPropertyName, overrideErrorMessage: 'Required'));
  }
}

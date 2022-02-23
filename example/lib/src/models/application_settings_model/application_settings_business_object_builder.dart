import 'package:ocean/ocean.dart';
import 'application_settings.dart';

class ApplicationSettingsBusinessObjectBuilder extends BusinessObjectMetadataBuilderBase<ApplicationSettings> {
  ApplicationSettingsBusinessObjectBuilder();

  @override
  void addSharedPropertyMetadata(PropertyMetadataManagerWrapper wrapper) {
    wrapper.addMetadata(CheckboxPropertyMetadata(propertyName: ApplicationSettings.showFavoritesPropertyName));
    wrapper.addMetadata(CheckboxPropertyMetadata(
        propertyName: ApplicationSettings.showHiddenSettingsPropertyName, subtitleText: 'Advanced Feature'));
    wrapper.addMetadata(SliderPropertyMetadata(
      propertyName: ApplicationSettings.storageLimitPropertyName,
      divisions: 10,
      min: 0,
      max: 100,
    ));
    wrapper.addMetadata(SliderPropertyMetadata(
      propertyName: ApplicationSettings.trashCanRetentionPropertyName,
      divisions: 7,
      min: 0,
      max: 94,
    ));
    wrapper.addMetadata(
      DropdownPropertyMetadata(
        propertyName: ApplicationSettings.themeNamePropertyName,
        labelText: 'Select Theme',
        notSelectedValue: OceanStringCharacterConstants.stringEmpty,
      ),
    );
    wrapper.addMetadata(
      DropdownPropertyMetadata(
        propertyName: ApplicationSettings.defaultCategoryPropertyName,
        labelText: 'Select Default Category',
        notSelectedValue: OceanNumericConstants.zero,
      ),
    );
  }

  @override
  void addSharedStringCasingFormatRules(StringFormatRulesManagerWrapper wrapper) {}

  @override
  void addSharedValidationRules(ValidationRulesManagerWrapper wrapper) {
    wrapper.addRule(CompareValueValidator(
        ApplicationSettings.themeNamePropertyName, OceanStringCharacterConstants.stringEmpty, ComparisionType.notEqual,
        overrideErrorMessage: '${ApplicationSettings.themeNamePropertyName.toTitleCase()} is required.'));
    wrapper.addRule(CompareValueValidator(
        ApplicationSettings.defaultCategoryPropertyName, OceanNumericConstants.zero, ComparisionType.greaterThan,
        overrideErrorMessage: '${ApplicationSettings.defaultCategoryPropertyName.toTitleCase()} is required.'));
  }
}

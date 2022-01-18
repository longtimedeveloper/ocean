class MessageConstants {
  /// Provides three placeholders, {0} was not found in {1}, unable to perform {3}.
  static const String itemNotFoundInCollectionFormat = '{0} was not found in {1}, unable to perform {3}.';
}

class StringConstants {
  /// Provides, !@#$*&^%()-_+|
  static const String allowedSpecialCharacters = '!@#\$*&^-_+|()%';

  /// Provides, Ocean Example (ported from .NET C#)
  static const String appTitle = 'Ocean Example';

  /// Provides, ConfirmPasswordOceanPasswordFormField
  static const String confirmPasswordOceanPasswordFormField = "ConfirmPasswordOceanPasswordFormField";

  /// Provides, PasswordOceanPasswordFormField
  static const String passwordOceanPasswordFormField = "PasswordOceanPasswordFormField";

  /// Provides, SaveButton
  static const String saveButton = "SaveButton";
}

class NumericConstant {
  /// Provides, 10
  static const int goldStandardForPasswordLength = 10;

  /// Provides, 5
  static const int recommendedMaxErrorLinesForPasswordField = 5;
}

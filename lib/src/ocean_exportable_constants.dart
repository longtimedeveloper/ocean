class OceanStringCharacterConstants {
  /// Provides, double white space
  static const String doubleSpace = '  ';

  /// Provides, '\n'
  static const String newLineCharacter = '\n';

  /// Provides, |
  static const String pipeSymbol = '|';

  /// Provides, single white space
  static const String singleSpace = ' ';

  /// Provides, empty string
  static const String stringEmpty = '';
}

class OceanStringWordConstants {
  /// Provides, !@#$*&^%()-_+|
  static const String defaultSpecialCharacters = '!@#\$*&^-_+|()%';

  /// Provides, lower
  static const String lower = 'lower';

  /// Provides, phone
  static const String phone = 'phone';

  /// Provides, proper
  static const String proper = 'proper';

  /// Provides, upper
  static const String upper = 'upper';
}

class OceanNumericConstants {
  /// Provides, 9
  static const int bankRoutingNumberRequiredLength = 9;

  /// Provides, -1
  static const int minusOne = -1;

  /// Provides, 1
  static const int one = 1;

  /// Provides, 0
  static const int zero = 0;
}

class OceanRegExPatternConstants {
  /// Provides, r'(?=[A-Z])'
  static const String capitalLetter = r'(?=[A-Z])';

  /// Provides regex pattern for 0-9, r[0-9]
  static const String digits = r'[0-9]';

  /// Provides regex pattern for ^\d+$, r'^\d+$'
  static const String digitsOnly = r'^\d+$';

  /// Provides regex pattern for, email,  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
  static const String email =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  /// Provides regex pattern for, ip address, r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$"
  static const String ipAddress = r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$";

  /// Provides regex pattern for a-z, [a-z]+
  static const String letters = '[a-z]+';

  /// Provides regex pattern for a-z, r[a-z]
  static const String lowerCaseLetters = r'[a-z]';

  /// Provides regex pattern for spaces, '\\s+'
  static const String spaces = '\\s+';

  /// Provides regex pattern for, ssn.
  static const String ssn = r"^(?!219-09-9999|078-05-1120)(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$";

  /// Provides regex pattern for A-Za-z, r'[A-Za-z]'
  static const String upperAndLowerCaseLetters = r'[A-Za-z]';

  /// Provides regex pattern for A-Z, r[A-Z]
  static const String upperCaseLetters = r'[A-Z]';

  /// Provides regex pattern http, https, and ftp urls r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|ftp:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?|^((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|ftp:\/\/)?([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";
  static const String urlHttpHttpsFtp =
      r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|ftp:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?|^((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/|ftp:\/\/)?([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";

  /// Provides regex pattern for, US phone number, r"^\(?([0-9]{3})\)?[\s-.●]?([0-9]{3})[-.●]?([0-9]{4}).*$"
  static const String usPhoneNumber = r"^\(?([0-9]{3})\)?[\s-.●]?([0-9]{3})[-.●]?([0-9]{4}).*$";

  /// Provides regex pattern for, US zip code, r"^\\d{5}(-\\d{4})?$"
  static const String usZipCode = r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$";
}

class OceanPasswordFieldConstants {
  /// Provides, Confirm
  static const String passwordConfirmLabelPrefix = 'Confirm';

  /// Provides, PasswordFieldIconButtonKey
  static const String passwordFieldIconButtonKey = 'PasswordFieldIconButtonKey';

  /// Provides, 5
  static const int passwordFormFieldDefultErrorMaxLines = 5;

  /// Provides, 2
  static const int passwordFormFieldMinimumErrorMaxLines = 2;
}

class OceanValidationConstants {
  /// Provides, Delete
  static const String delete = 'Delete';

  /// Provides, Insert
  static const String insert = 'Insert';

  /// Provides, Insert|Delete|Update
  static const String insertDeleteUpdate = 'Insert|Delete|Update';

  /// Provides, Insert|Update
  static const String insertUpdate = 'Insert|Update';

  /// Provides, |
  static const String ruleSetDelimiter = '|';

  /// Provides, Update
  static const String update = 'Update';

  /// Provides, Update|Delete
  static const String updateDelete = 'Update|Delete';
}

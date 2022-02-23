import 'package:ocean/ocean.dart';

class SignIn extends BusinessObjectBase {
  SignIn._();

  factory SignIn.create({String activeRuleSet = OceanValidationConstants.insert}) {
    final userRegistration = SignIn._();
    userRegistration.activeRuleSet = activeRuleSet;
    userRegistration.checkAllRules();
    return userRegistration;
  }

  factory SignIn.fromMap(Map<String, dynamic> map, {String activeRuleSet = OceanValidationConstants.update}) {
    final userRegistration = SignIn._()
      .._email = map[emailPropertyName]
      .._password = map[passwordPropertyName];

    if (map[BusinessObjectBase.activeRuleSetPropertyName] != null) {
      userRegistration.activeRuleSet = map[BusinessObjectBase.activeRuleSetPropertyName]!;
    } else {
      userRegistration.activeRuleSet = activeRuleSet;
    }
    userRegistration.checkAllRules();
    return userRegistration;
  }

  /// Provides, 50
  static const int emailMaximumLength = 50;

  /// Provides, 5
  static const int emailMinimumLength = 7;

  /// Provides, email
  static const String emailPropertyName = 'email';

  /// Provides, 25
  static const int passwordMaximumLength = 25;

  /// Provides, 1
  static const int passwordMinimumLength = 1;

  /// Provides, password
  static const String passwordPropertyName = 'password';

  String _email = OceanStringCharacterConstants.stringEmpty;
  String _password = OceanStringCharacterConstants.stringEmpty;

  @override
  Map<String, dynamic> toJson() => {
        BusinessObjectBase.activeRuleSetPropertyName: activeRuleSet,
        emailPropertyName: email,
        passwordPropertyName: password,
      };

  String get email {
    return _email;
  }

  String get password {
    return _password;
  }

  set email(String value) {
    _email = setPropertyValue(emailPropertyName, _email, value);
  }

  set password(String value) {
    _password = setPropertyValue(passwordPropertyName, _password, value);
  }
}

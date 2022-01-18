import 'package:ocean/ocean.dart';

class UserRegistration extends BusinessObjectBase {
  UserRegistration._();

  factory UserRegistration.create({String activeRuleSet = ValidationConstants.insert}) {
    final userRegistration = UserRegistration._();
    userRegistration.activeRuleSet = activeRuleSet;
    userRegistration.checkAllRules();
    return userRegistration;
  }

  factory UserRegistration.fromMap(Map<String, dynamic> map, {String activeRuleSet = ValidationConstants.update}) {
    final userRegistration = UserRegistration._()
      .._acknowledgeTerms = map[acknowledgeTermsPropertyName]
      .._password = map[passwordPropertyName]
      .._userName = map[userNamePropertyName];

    if (map[BusinessObjectBase.activeRuleSetPropertyName] != null) {
      userRegistration.activeRuleSet = map[BusinessObjectBase.activeRuleSetPropertyName]!;
    } else {
      userRegistration.activeRuleSet = activeRuleSet;
    }
    userRegistration.checkAllRules();
    return userRegistration;
  }

  /// Provides, 1
  static const int acknowledgeTermsMaximumLength = 1;

  /// Provides, 1
  static const int acknowledgeTermsMinimumLength = 1;

  /// Provides, acknowledgeTerms
  static const String acknowledgeTermsPropertyName = 'acknowledgeTerms';

  /// Provides, 25
  static const int passwordMaximumLength = 25;

  /// Provides, 7
  static const int passwordMinimumLength = 7;

  /// Provides, password
  static const String passwordPropertyName = 'password';

  /// Provides, 25
  static const int userNameMaximumLength = 25;

  /// Provides, 5
  static const int userNameMinimumLength = 7;

  /// Provides, userName
  static const String userNamePropertyName = 'userName';

  bool _acknowledgeTerms = false;
  String _password = StringCharacterConstants.stringEmpty;
  String _userName = StringCharacterConstants.stringEmpty;

  @override
  Map<String, dynamic> toJson() => {
        BusinessObjectBase.activeRuleSetPropertyName: activeRuleSet,
        acknowledgeTermsPropertyName: acknowledgeTerms,
        passwordPropertyName: password,
        userNamePropertyName: userName,
      };

  bool get acknowledgeTerms {
    return _acknowledgeTerms;
  }

  String get password {
    return _password;
  }

  String get userName {
    return _userName;
  }

  set acknowledgeTerms(bool value) {
    _acknowledgeTerms = setPropertyValue(acknowledgeTermsPropertyName, _acknowledgeTerms, value);
  }

  set password(String value) {
    _password = setPropertyValue(passwordPropertyName, _password, value);
  }

  set userName(String value) {
    _userName = setPropertyValue(userNamePropertyName, _userName, value);
  }
}

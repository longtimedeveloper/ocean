import 'package:ocean/ocean.dart';

class Customer extends BusinessObjectBase {
  Customer._();

  factory Customer.create({String activeRuleSet = OceanValidationConstants.insert}) {
    final demo = Customer._();
    demo.activeRuleSet = activeRuleSet;
    demo.checkAllRules();
    return demo;
  }

  factory Customer.fromMap(Map<String, dynamic> map, {String activeRuleSet = OceanValidationConstants.update}) {
    final demo = Customer._()
      .._cellPhone = map[cellPhonePropertyName]
      .._email = map[emailPropertyName]
      .._firstName = map[firstNamePropertyName]
      .._lastName = map[lastNamePropertyName]
      .._phone = map[phonePropertyName];

    if (map[BusinessObjectBase.activeRuleSetPropertyName] != null) {
      demo.activeRuleSet = map[BusinessObjectBase.activeRuleSetPropertyName]!;
    } else {
      demo.activeRuleSet = activeRuleSet;
    }
    demo.checkAllRules();
    return demo;
  }

  /// Provides, 14
  static const int cellPhoneMaximumLength = 14;

  /// Provides, 10
  static const int cellPhoneMinimumLength = 10;

  /// Provides, cellPhone
  static const String cellPhonePropertyName = 'cellPhone';

  /// Provides, 50
  static const int emailMaximumLength = 50;

  /// Provides, 7
  static const int emailMinimumLength = 7;

  /// Provides, email
  static const String emailPropertyName = 'email';

  /// Provides, 25
  static const int firstNameMaximumLength = 25;

  /// Provides, 1
  static const int firstNameMinimumLength = 1;

  /// Provides, firstName
  static const String firstNamePropertyName = 'firstName';

  /// Provides, 25
  static const int lastNameMaximumLength = 25;

  /// Provides, 1
  static const int lastNameMinimumLength = 1;

  /// Provides, lastName
  static const String lastNamePropertyName = 'lastName';

  /// Provides, 50
  static const int phoneMaximumLength = 50;

  /// Provides, 10
  static const int phoneMinimumLength = 10;

  /// Provides, phone
  static const String phonePropertyName = 'phone';

  String _cellPhone = OceanStringCharacterConstants.stringEmpty;
  String _email = OceanStringCharacterConstants.stringEmpty;
  String _firstName = OceanStringCharacterConstants.stringEmpty;
  String _lastName = OceanStringCharacterConstants.stringEmpty;
  String _phone = OceanStringCharacterConstants.stringEmpty;

  @override
  Map<String, dynamic> toJson() => {
        BusinessObjectBase.activeRuleSetPropertyName: activeRuleSet,
        cellPhonePropertyName: cellPhone,
        emailPropertyName: email,
        firstNamePropertyName: firstName,
        lastNamePropertyName: lastName,
        phonePropertyName: phone,
      };

  String get cellPhone {
    return _cellPhone;
  }

  String get email {
    return _email;
  }

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  String get phone {
    return _phone;
  }

  set cellPhone(String value) {
    _cellPhone = setPropertyValue(cellPhonePropertyName, _cellPhone, value);
  }

  set email(String value) {
    _email = setPropertyValue(emailPropertyName, _email, value);
  }

  set firstName(String value) {
    _firstName = setPropertyValue(firstNamePropertyName, _firstName, value);
  }

  set lastName(String value) {
    _lastName = setPropertyValue(lastNamePropertyName, _lastName, value);
  }

  set phone(String value) {
    _phone = setPropertyValue(phonePropertyName, _phone, value);
  }
}

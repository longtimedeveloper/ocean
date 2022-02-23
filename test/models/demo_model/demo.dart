import 'package:ocean/ocean.dart';

class Demo extends BusinessObjectBase {
  Demo._();

  factory Demo.create({String activeRuleSet = OceanValidationConstants.insert}) {
    final demo = Demo._();
    demo.activeRuleSet = activeRuleSet;
    demo.checkAllRules();
    return demo;
  }

  factory Demo.createAndPopulate({String activeRuleSet = OceanValidationConstants.insert}) {
    final demo = Demo._();
    demo.checkAllRules();
    demo.activeRuleSet = activeRuleSet;
    demo.cellPhone = '555-555-5555';
    demo.email = 'dart@acme.com';
    demo.firstName = 'Dart';
    demo.lastName = 'Flutter';
    demo.phone = '555-555-5555';
    demo.age = 5;
    demo.favorites = 100;
    demo.password = 'dar4&G7ywZ';
    demo.userName = 'dartrocks';
    demo.resetAfterSaving();
    return demo;
  }

  factory Demo.fromMap(Map<String, dynamic> map) {
    final demo = Demo._()
      .._age = map[agePropertyName]
      .._cellPhone = map[cellPhonePropertyName]
      .._dummy = map[dummyPropertyName]
      .._email = map[emailPropertyName]
      .._favorites = map[favoritesPropertyName]
      .._firstName = map[firstNamePropertyName]
      .._lastName = map[lastNamePropertyName]
      .._password = map[passwordPropertyName]
      .._phone = map[phonePropertyName]
      .._userName = map[userNamePropertyName];
    demo.checkAllRules();
    return demo;
  }

  /// Provides, 3
  static const int ageMaximumLength = 3;

  /// Provides, 1
  static const int ageMinimumLength = 1;

  /// Provides, age
  static const String agePropertyName = 'age';

  /// Provides, 14
  static const int cellPhoneMaximumLength = 14;

  /// Provides, 10
  static const int cellPhoneMinimumLength = 10;

  /// Provides, cellPhone
  static const String cellPhonePropertyName = 'cellPhone';

  /// Provides, 5
  static const int dummyMaximumLength = 5;

  /// Provides, 1
  static const int dummyMinimumLength = 1;

  /// Provides, dummy
  static const String dummyPropertyName = 'dummy';

  /// Provides, 50
  static const int emailMaximumLength = 50;

  /// Provides, 7
  static const int emailMinimumLength = 7;

  /// Provides, email
  static const String emailPropertyName = 'email';

  /// Provides, 4
  static const int favoritesMaximumLength = 4;

  /// Provides, 1
  static const int favoritesMinimumLength = 1;

  /// Provides, favorites
  static const String favoritesPropertyName = 'favorites';

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

  /// Provides, 25
  static const int passwordMaximumLength = 25;

  /// Provides, 7
  static const int passwordMinimumLength = 7;

  /// Provides, password
  static const String passwordPropertyName = 'password';

  /// Provides, 50
  static const int phoneMaximumLength = 50;

  /// Provides, 10
  static const int phoneMinimumLength = 10;

  /// Provides, phone
  static const String phonePropertyName = 'phone';

  /// Provides, 25
  static const int userNameMaximumLength = 25;

  /// Provides, 7
  static const int userNameMinimumLength = 7;

  /// Provides, userName
  static const String userNamePropertyName = 'userName';

  int _age = 0;
  String _cellPhone = OceanStringCharacterConstants.stringEmpty;
  String? _dummy;
  String _email = OceanStringCharacterConstants.stringEmpty;
  int _favorites = 0;
  String _firstName = OceanStringCharacterConstants.stringEmpty;
  String _lastName = OceanStringCharacterConstants.stringEmpty;
  String _password = OceanStringCharacterConstants.stringEmpty;
  String _phone = OceanStringCharacterConstants.stringEmpty;
  String _userName = OceanStringCharacterConstants.stringEmpty;

  @override
  Map<String, dynamic> toJson() => {
        agePropertyName: age,
        cellPhonePropertyName: cellPhone,
        dummyPropertyName: dummy,
        emailPropertyName: email,
        favoritesPropertyName: favorites,
        firstNamePropertyName: firstName,
        lastNamePropertyName: lastName,
        passwordPropertyName: password,
        phonePropertyName: phone,
        userNamePropertyName: userName,
      };

  int get age {
    return _age;
  }

  String get cellPhone {
    return _cellPhone;
  }

  String? get dummy {
    return _dummy;
  }

  String get email {
    return _email;
  }

  int get favorites {
    return _favorites;
  }

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  String get password {
    return _password;
  }

  String get phone {
    return _phone;
  }

  String get userName {
    return _userName;
  }

  set age(int value) {
    _age = setPropertyValue(agePropertyName, _age, value);
  }

  set cellPhone(String value) {
    _cellPhone = setPropertyValue(cellPhonePropertyName, _cellPhone, value);
  }

  set dummy(String? value) {
    _dummy = setPropertyValue(dummyPropertyName, _dummy, value);
  }

  set email(String value) {
    _email = setPropertyValue(emailPropertyName, _email, value);
  }

  set favorites(int value) {
    _favorites = setPropertyValue(favoritesPropertyName, _favorites, value);
  }

  set firstName(String value) {
    _firstName = setPropertyValue(firstNamePropertyName, _firstName, value);
  }

  set lastName(String value) {
    _lastName = setPropertyValue(lastNamePropertyName, _lastName, value);
  }

  set password(String value) {
    _password = setPropertyValue(passwordPropertyName, _password, value);
  }

  set phone(String value) {
    _phone = setPropertyValue(phonePropertyName, _phone, value);
  }

  set userName(String value) {
    _userName = setPropertyValue(userNamePropertyName, _userName, value);
  }
}

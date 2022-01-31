import 'package:ocean/ocean.dart';

class UserOptions extends BusinessObjectBase {
  UserOptions._();

  factory UserOptions.create({String activeRuleSet = ValidationConstants.insert}) {
    final userRegistration = UserOptions._();
    userRegistration.activeRuleSet = activeRuleSet;
    userRegistration.checkAllRules();
    return userRegistration;
  }

  factory UserOptions.fromMap(Map<String, dynamic> map, {String activeRuleSet = ValidationConstants.update}) {
    final userRegistration = UserOptions._()
      .._acknowledgeClubTerms = map[acknowledgeClubTermsPropertyName]
      .._acknowledgeTerms = map[acknowledgeTermsPropertyName]
      .._joinClub = map[joinClubPropertyName];

    if (map[BusinessObjectBase.activeRuleSetPropertyName] != null) {
      userRegistration.activeRuleSet = map[BusinessObjectBase.activeRuleSetPropertyName]!;
    } else {
      userRegistration.activeRuleSet = activeRuleSet;
    }
    userRegistration.checkAllRules();
    return userRegistration;
  }

  /// Provides, acknowledgeClubTerms
  static const String acknowledgeClubTermsPropertyName = 'acknowledgeClubTerms';

  /// Provides, acknowledgeTerms
  static const String acknowledgeTermsPropertyName = 'acknowledgeTerms';

  /// Provides, joinClub
  static const String joinClubPropertyName = 'joinClub';

  /// Provides, joinMarketingMessages
  static const String joinMarketingMessagesPropertyName = 'joinMarketingMessages';

  bool _acknowledgeClubTerms = false;
  bool _acknowledgeTerms = false;
  bool _joinClub = false;
  bool _joinMarketingMessages = false;

  @override
  Map<String, dynamic> toJson() => {
        BusinessObjectBase.activeRuleSetPropertyName: activeRuleSet,
        acknowledgeTermsPropertyName: acknowledgeTerms,
        acknowledgeClubTermsPropertyName: acknowledgeClubTerms,
        joinClubPropertyName: joinClub,
        joinMarketingMessagesPropertyName: joinMarketingMessages,
      };

  bool get acknowledgeClubTerms {
    return _acknowledgeClubTerms;
  }

  bool get acknowledgeTerms {
    return _acknowledgeTerms;
  }

  bool get joinClub {
    return _joinClub;
  }

  bool get joinMarketingMessages {
    return _joinMarketingMessages;
  }

  set acknowledgeClubTerms(bool value) {
    _acknowledgeClubTerms = setPropertyValue(acknowledgeClubTermsPropertyName, _acknowledgeClubTerms, value);
  }

  set acknowledgeTerms(bool value) {
    _acknowledgeTerms = setPropertyValue(acknowledgeTermsPropertyName, _acknowledgeTerms, value);
  }

  set joinClub(bool value) {
    _joinClub = setPropertyValue(joinClubPropertyName, _joinClub, value);
  }

  set joinMarketingMessages(bool value) {
    _joinMarketingMessages = setPropertyValue(joinMarketingMessagesPropertyName, _joinMarketingMessages, value);
  }
}

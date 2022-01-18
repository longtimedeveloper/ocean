import 'dart:collection';
import 'string_casing.dart';
import '../infrastructure/infrastructure.dart';
import '../ocean_constants.dart';

class SharedStringCasingChecks {
  // ignore: unused_element
  SharedStringCasingChecks._();

  static SharedStringCasingChecks? _instance;

  List<StringCasingCheck>? _internalStringCasingChecks;
  UnmodifiableListView<StringCasingCheck>? _unmodifiableListViewStringCasingChecks;

  UnmodifiableListView<StringCasingCheck> get getStringCasingChecks {
    if (_internalStringCasingChecks == null) {
      throw OceanException(MessageConstants.sharedStringCasingChecksMustBeLoaded);
    }
    return _unmodifiableListViewStringCasingChecks!;
  }

  static SharedStringCasingChecks get instance => _instance ??= SharedStringCasingChecks._();

  void addStringCasingCheck(StringCasingCheck stringCasingCheck) {
    if (_internalStringCasingChecks == null) {
      throw OceanException(MessageConstants.sharedStringCasingChecksMustBeLoaded);
    }
    _internalStringCasingChecks!.add(stringCasingCheck);
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void loadChecks(List<StringCasingCheck> stringCasingChecks) {
    _internalStringCasingChecks = stringCasingChecks;
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void loadDefaultChecks() {
    var stringCasingChecks = <StringCasingCheck>[];
    stringCasingChecks.add(StringCasingCheck(lookFor: '.Com ', replaceWith: '.com '));
    stringCasingChecks.add(StringCasingCheck(lookFor: '.Com.', replaceWith: '.com.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: '.net ', replaceWith: '.NET '));
    stringCasingChecks.add(StringCasingCheck(lookFor: '.net.', replaceWith: '.NET.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Aaa ', replaceWith: 'AAA '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'And ', replaceWith: 'and '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Api ', replaceWith: 'API '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Api.', replaceWith: 'API.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'C/O ', replaceWith: 'c/o '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Ios ', replaceWith: 'iOS '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Ios.', replaceWith: 'iOS.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Iphone ', replaceWith: 'iPhone '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Iphone.', replaceWith: 'iPhone.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Lc ', replaceWith: 'LC '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Lc.', replaceWith: 'LC.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Lc. ', replaceWith: 'LC. '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Lc.', replaceWith: 'LC.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Llc ', replaceWith: 'LLC '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Llc.', replaceWith: 'LLC.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Llc. ', replaceWith: 'LLC. '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Llc.', replaceWith: 'LLC.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Ne ', replaceWith: 'NE '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Nw ', replaceWith: 'NW '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Or ', replaceWith: 'or '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Po Box', replaceWith: 'PO Box'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Rss ', replaceWith: 'RSS '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Rss.', replaceWith: 'RSS.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Se ', replaceWith: 'SE '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Ssid ', replaceWith: 'SSID '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Ssid.', replaceWith: 'SSID.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Sw ', replaceWith: 'SW '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Usa ', replaceWith: 'USA '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Usa.', replaceWith: 'USA.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Vpn ', replaceWith: 'VPN '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Vpn.', replaceWith: 'VPN.'));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Wpf ', replaceWith: 'WPF '));
    stringCasingChecks.add(StringCasingCheck(lookFor: 'Wpf.', replaceWith: 'WPF.'));
    stringCasingChecks
        .add(StringCasingCheck(lookFor: 'Mac', replaceWith: 'Mac', stringCasingMethod: StringCasingMethod.regEx));
    stringCasingChecks
        .add(StringCasingCheck(lookFor: 'Mc', replaceWith: 'Mc', stringCasingMethod: StringCasingMethod.regEx));
    stringCasingChecks
        .add(StringCasingCheck(lookFor: 'O\'', replaceWith: 'O\'', stringCasingMethod: StringCasingMethod.regEx));

    _internalStringCasingChecks = stringCasingChecks;
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void _updateUnmodifiableListViewStringCasingChecks() {
    _unmodifiableListViewStringCasingChecks = UnmodifiableListView(_internalStringCasingChecks!);
  }
}

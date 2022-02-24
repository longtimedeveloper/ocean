import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';
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
    final test = _internalStringCasingChecks!.singleWhereOrNull((element) => element.id == stringCasingCheck.id);
    if (test != null) {
      throw OceanException(MessageConstants.sharedStringCasingChecksAlreadyInDatabase);
    }
    _internalStringCasingChecks!.add(stringCasingCheck);
    _internalStringCasingChecks!.sort();
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void loadChecks(List<StringCasingCheck> stringCasingChecks) {
    _internalStringCasingChecks = stringCasingChecks;
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void loadDefaultChecks() {
    var stringCasingChecks = <StringCasingCheck>[];
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: '.Com ', replaceWith: '.com '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: '.Com.', replaceWith: '.com.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: '.net ', replaceWith: '.NET '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: '.net.', replaceWith: '.NET.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Aaa ', replaceWith: 'AAA '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'And ', replaceWith: 'and '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Api ', replaceWith: 'API '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Api.', replaceWith: 'API.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'C/O ', replaceWith: 'c/o '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Ios ', replaceWith: 'iOS '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Ios.', replaceWith: 'iOS.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Iphone ', replaceWith: 'iPhone '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Iphone.', replaceWith: 'iPhone.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Lc ', replaceWith: 'LC '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Lc.', replaceWith: 'LC.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Lc. ', replaceWith: 'LC. '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Lc.', replaceWith: 'LC.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Llc ', replaceWith: 'LLC '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Llc.', replaceWith: 'LLC.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Llc. ', replaceWith: 'LLC. '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Llc.', replaceWith: 'LLC.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Ne ', replaceWith: 'NE '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Nw ', replaceWith: 'NW '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Or ', replaceWith: 'or '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Po Box', replaceWith: 'PO Box'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Rss ', replaceWith: 'RSS '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Rss.', replaceWith: 'RSS.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Se ', replaceWith: 'SE '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Ssid ', replaceWith: 'SSID '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Ssid.', replaceWith: 'SSID.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Sw ', replaceWith: 'SW '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Usa ', replaceWith: 'USA '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Usa.', replaceWith: 'USA.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Vpn ', replaceWith: 'VPN '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Vpn.', replaceWith: 'VPN.'));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Wpf ', replaceWith: 'WPF '));
    stringCasingChecks.add(StringCasingCheck(id: const Uuid().v1(), lookFor: 'Wpf.', replaceWith: 'WPF.'));
    stringCasingChecks.add(StringCasingCheck(
        id: const Uuid().v1(), lookFor: 'Mac', replaceWith: 'Mac', stringCasingMethod: StringCasingMethod.regEx));
    stringCasingChecks.add(StringCasingCheck(
        id: const Uuid().v1(), lookFor: 'Mc', replaceWith: 'Mc', stringCasingMethod: StringCasingMethod.regEx));
    stringCasingChecks.add(StringCasingCheck(
        id: const Uuid().v1(), lookFor: 'O\'', replaceWith: 'O\'', stringCasingMethod: StringCasingMethod.regEx));

    _internalStringCasingChecks = stringCasingChecks;
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void removeStringCasingCheck(String id) {
    if (_internalStringCasingChecks == null) {
      throw OceanException(MessageConstants.sharedStringCasingChecksMustBeLoaded);
    }
    final test = _internalStringCasingChecks!.singleWhereOrNull((element) => element.id == id);
    if (test == null) {
      throw OceanException(MessageConstants.sharedStringCasingChecksNotInDatabase);
    }
    _internalStringCasingChecks!.removeWhere((element) => element.id == id);
    _updateUnmodifiableListViewStringCasingChecks();
  }

  void _updateUnmodifiableListViewStringCasingChecks() {
    _unmodifiableListViewStringCasingChecks = UnmodifiableListView(_internalStringCasingChecks!);
  }
}

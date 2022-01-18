import 'dart:collection';
import '../src.dart';

class StateAbbreviationNameTool {
  StateAbbreviationNameTool._() {
    _initialize();
  }

  static StateAbbreviationNameTool? _instance;

  final Map<String, String> _states = <String, String>{};

  static StateAbbreviationNameTool get instance => _instance ??= StateAbbreviationNameTool._();

  /// Unfortunately the US Government messed up the AE states, because they assigned FOUR state names to AE!!!!
  /// If you would all FOUR AE records to be included set the optional [includeOtherAEEntries] argument to true.
  /// The default state name for AE is Armed Forces Europe.
  /// The other state names with AE are Armed Forces Africa, Armed Forces Canada, and Armed Forces Middle East.
  UnmodifiableListView<KeyValuePair> getStateAbbreviationAndNames({bool includeOtherAEEntries = false}) {
    final states = <KeyValuePair>[];

    _states.forEach((key, value) {
      states.add(KeyValuePair(key, value));
    });

    if (includeOtherAEEntries) {
      states.add(KeyValuePair('AE', 'Armed Forces Africa'));
      states.add(KeyValuePair('AE', 'Armed Forces Canada'));
      states.add(KeyValuePair('AE', 'Armed Forces Middle East'));

      states.sort((a, b) => (a.key.toString() + a.value.toString()).compareTo(b.key.toString() + b.value.toString()));
    }

    return UnmodifiableListView<KeyValuePair>(states);
  }

  /// Always call '[isValid]' before calling this method.  This method will throw if the [stateAbbreviation] is not found.
  String getStateName(String stateAbbreviation) {
    if (isValid(stateAbbreviation)) {
      return _states[stateAbbreviation]!;
    }
    throw OceanArgumentException(
      FieldNameConstants.stateAbbreviation,
      MessageConstants.stateNotFoundForStateAppreviationFormat.formatString(stateAbbreviation),
    );
  }

  bool isValid(String stateAbbreviation) {
    return _states.containsKey(stateAbbreviation);
  }

  void _initialize() {
    // Leave it up to the government to foul this up!!!
    // Using AE 4 times.  Who's in charge up there!
    //
    // _states['AE']  = 'Armed Forces Europe';
    // _states['AE']  = 'Armed Forces Africa')
    // _states['AE']  = 'Armed Forces Canada')
    // _states['AE']  = 'Armed Forces Middle East')

    _states['AA'] = 'Armed Forces Americas';
    _states['AE'] = 'Armed Forces Europe';
    _states['AK'] = 'Alaska';
    _states['AL'] = 'Alabama';
    _states['AP'] = 'Armed Forces Pacific';
    _states['AR'] = 'Arkansas';
    _states['AS'] = 'American Samoa';
    _states['AZ'] = 'Arizona';
    _states['CA'] = 'California';
    _states['CO'] = 'Colorado';
    _states['CT'] = 'Connecticut';
    _states['DC'] = 'District of Columbia';
    _states['DE'] = 'Delaware';
    _states['FL'] = 'Florida';
    _states['FM'] = 'Federated States of Micronesia';
    _states['GA'] = 'Georgia';
    _states['HI'] = 'Hawaii';
    _states['IA'] = 'Iowa';
    _states['ID'] = 'Idaho';
    _states['IL'] = 'Illinois';
    _states['IN'] = 'Indiana';
    _states['KS'] = 'Kansas';
    _states['KY'] = 'Kentucky';
    _states['LA'] = 'Louisiana';
    _states['MA'] = 'Massachusetts';
    _states['MD'] = 'Maryland';
    _states['ME'] = 'Maine';
    _states['MH'] = 'Marshall Islands';
    _states['MI'] = 'Michigan';
    _states['MN'] = 'Minnesota';
    _states['MO'] = 'Missouri';
    _states['MP'] = 'Northern Mariana Islands';
    _states['MS'] = 'Mississippi';
    _states['MT'] = 'Montana';
    _states['NC'] = 'North Carolina';
    _states['ND'] = 'North Dakota';
    _states['NE'] = 'Nebraska';
    _states['NH'] = 'New Hampshire';
    _states['NJ'] = 'New Jersey';
    _states['NM'] = 'New Mexico';
    _states['NV'] = 'Nevada';
    _states['NY'] = 'New York';
    _states['OH'] = 'Ohio';
    _states['OK'] = 'Oklahoma';
    _states['OR'] = 'Oregon';
    _states['PA'] = 'Pennsylvania';
    _states['PR'] = 'Puerto Rico';
    _states['PW'] = 'Palau';
    _states['RI'] = 'Rhode Island';
    _states['SC'] = 'South Carolina';
    _states['SD'] = 'South Dakota';
    _states['TN'] = 'Tennessee';
    _states['TX'] = 'Texas';
    _states['UT'] = 'Utah';
    _states['VA'] = 'Virginia';
    _states['VI'] = 'Virgin Islands';
    _states['VT'] = 'Vermont';
    _states['WA'] = 'Washington';
    _states['WI'] = 'Wisconsin';
    _states['WV'] = 'West Virginia';
    _states['WY'] = 'Wyoming';
  }
}

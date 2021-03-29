import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static SharedPreferences _preferences;

  static Future<void> initialize() async =>
      _preferences = await SharedPreferences.getInstance();

  static final _isNew = 'IsNew';
  static final _starName = 'StarName';
  static final _dateOfBirth = 'DateOfBirth';

  setIsNew(bool isNew) async => await _preferences.setBool(_isNew, isNew);

  bool getIsNew() => _preferences.getBool(_isNew) ?? false;

  setStarName(String starName) async =>
      await _preferences.setString(_starName, starName);

  String getStarName() => _preferences.getString(_starName) ?? '';

  setDateOfBirth(String dateOfBirth) async =>
      await _preferences.setString(_dateOfBirth, dateOfBirth);

  String getDateOfBirth() => _preferences.getString(_dateOfBirth) ?? '';

  Future clearData() async => await _preferences.clear();
}

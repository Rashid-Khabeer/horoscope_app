import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static SharedPreferences _preferences;

  static Future<void> initialize() async =>
      _preferences = await SharedPreferences.getInstance();

  static final _isNew = 'IsNew';
  static final _starName = 'StarName';
  static final _dateOfBirth = 'DateOfBirth';
  static final _email = 'Email';
  static final _isSignIn = 'IsSignIn';
  static final _hasPayed = 'HasPayed';

  setIsNew(bool isNew) async => await _preferences.setBool(_isNew, isNew);

  bool getIsNew() => _preferences.getBool(_isNew) ?? false;

  setStarName(String starName) async =>
      await _preferences.setString(_starName, starName);

  String getStarName() => _preferences.getString(_starName) ?? '';

  setEmail(String email) async => await _preferences.setString(_email, email);

  String getEmail() => _preferences.getString(_email) ?? '';

  setDateOfBirth(String dateOfBirth) async =>
      await _preferences.setString(_dateOfBirth, dateOfBirth);

  String getDateOfBirth() => _preferences.getString(_dateOfBirth) ?? '';

  setIsSignIn(bool value) async => await _preferences.setBool(_isSignIn, value);

  bool getSignIn() => _preferences.getBool(_isSignIn) ?? false;

  setHasPayed(bool value) async => await _preferences.setBool(_hasPayed, value);

  bool getHasPayed() => _preferences.getBool(_hasPayed) ?? false;

  Future clearData() async => await _preferences.clear();
}

import 'package:shared_preferences/shared_preferences.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class SharedPrefs {
  static final SharedPrefs _instancia = SharedPrefs._internal();

  SharedPrefs._internal();

  factory SharedPrefs() {
    return _instancia;
  }

  static late SharedPreferences _prefs;

  static initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs;
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
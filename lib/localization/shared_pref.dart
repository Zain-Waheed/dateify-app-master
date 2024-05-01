import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static saveValue(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lang', id);
  }

  static getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    int? intValue = await prefs.getInt('lang');
    print(intValue ?? 1111);
    return intValue ?? 0;
  }

  static removeLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("KEY_LOGGED_IN");
  }
}

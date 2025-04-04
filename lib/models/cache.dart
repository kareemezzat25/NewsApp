import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  static late SharedPreferences _container;
  

  static processInitialize() async {
    _container = await SharedPreferences.getInstance();
  }

  static Future<bool> setLastStartDate(String startDate) {
    return _container.setString('lastStart', startDate);
  }

  static String getLastStartDate() {
    return _container.getString('lastStart') ?? '';
  }

  static Future<bool> setLastStopDate(String stopDate) {
    return _container.setString('lastStop', stopDate);
  }

  static String getLastStopDate() {
    return _container.getString('lastStop') ?? '';
  }
}
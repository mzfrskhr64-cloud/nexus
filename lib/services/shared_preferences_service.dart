import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _themeKey = 'isDarkMode';
  static const String _loginKey ='isLoggedIn';
// حفظ حالت theme
  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _themeKey,
      isDarkMode,
    );
  }
// عرض حالت theme
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_themeKey) ?? false;
  }

  // حفظ حالت التسجيل
Future<void> saveLogin(bool isLoggedIn) async{
 final prefs =await SharedPreferences.getInstance();

 await prefs.setBool(
     _loginKey,
     isLoggedIn);

}
//استخدم التسجيل الحالي
Future<bool> getLogin() async{
    final prefs =  await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
}


}
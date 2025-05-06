import 'package:cryptools/domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultThemeRepository implements ThemeRepository {
  static const _key = 'isDarkMode';

  @override
  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  @override
  void setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDarkMode);
  }
}

import 'package:cryptools/domain/repositories/theme_repository.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final ThemeRepository _themeRepository;

  ThemeController({required ThemeRepository themeRepository})
    : _themeRepository = themeRepository;

  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() async {
    _isDarkMode.value = await _themeRepository.isDarkMode();
  }

  void setDarkMode(bool isDark) async {
    _themeRepository.setDarkMode(isDark);
    _isDarkMode.value = isDark;
  }
}

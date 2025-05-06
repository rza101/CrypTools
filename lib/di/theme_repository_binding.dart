import 'package:cryptools/data/repositories/default_theme_repository.dart';
import 'package:cryptools/domain/repositories/theme_repository.dart';
import 'package:get/get.dart';

class ThemeRepositoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeRepository>(() => DefaultThemeRepository());
  }
}

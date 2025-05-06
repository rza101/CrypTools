import 'package:cryptools/ui/theme/theme_controller.dart';
import 'package:get/get.dart';

class ThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController(themeRepository: Get.find()));
  }
}

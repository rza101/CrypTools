import 'package:cryptools/ui/screens/settings/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => SettingsController());
  }
}

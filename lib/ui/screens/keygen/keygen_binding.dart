import 'package:cryptools/ui/screens/keygen/keygen_controller.dart';
import 'package:get/get.dart';

class KeygenBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => KeygenController(keygenService: Get.find()));
  }
}

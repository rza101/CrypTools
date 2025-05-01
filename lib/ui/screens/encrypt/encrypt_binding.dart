import 'package:cryptools/ui/screens/encrypt/encrypt_controller.dart';
import 'package:get/get.dart';

class EncryptBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => EncryptController(
        encryptService: Get.find(),
        randomService: Get.find(),
      ),
    );
  }
}

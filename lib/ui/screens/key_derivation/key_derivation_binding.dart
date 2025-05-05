import 'package:cryptools/ui/screens/key_derivation/key_derivation_controller.dart';
import 'package:get/get.dart';

class KeyDerivationBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => KeyDerivationController(
        keyDerivationService: Get.find(),
        encodeService: Get.find(),
        randomService: Get.find(),
      ),
    );
  }
}

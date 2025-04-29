import 'package:cryptools/ui/screens/hash/hash_controller.dart';
import 'package:get/get.dart';

class HashBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => HashController(hashService: Get.find(), hmacService: Get.find()),
    );
  }
}

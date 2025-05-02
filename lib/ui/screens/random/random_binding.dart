import 'package:cryptools/ui/screens/random/random_controller.dart';
import 'package:get/get.dart';

class RandomBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(
      () => RandomController(
        encodeService: Get.find(),
        randomService: Get.find(),
      ),
    );
  }
}

import 'package:cryptools/ui/screens/encode/encode_controller.dart';
import 'package:get/get.dart';

class EncodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => EncodeController(encodeService: Get.find()));
  }
}

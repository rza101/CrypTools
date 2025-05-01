import 'package:cryptools/ui/screens/history/history_controller.dart';
import 'package:get/get.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => HistoryController());
  }
}

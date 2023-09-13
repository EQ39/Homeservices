import 'package:get/get.dart';
import 'package:homeservice/app/controller/history_controller.dart';

class HistoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => HistoryController(parser: Get.find()),
    );
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/controller/complaints_controller.dart';

class ComplaintsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ComplaintsController(parser: Get.find()),
    );
  }
}

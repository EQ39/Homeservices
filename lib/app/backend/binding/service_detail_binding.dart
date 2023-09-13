import 'package:get/get.dart';
import 'package:homeservice/app/controller/service_detail_controller.dart';

class ServiceDetailBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ServiceDetailController(parser: Get.find()),
    );
  }
}

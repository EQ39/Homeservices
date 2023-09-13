import 'package:get/get.dart';
import 'package:homeservice/app/controller/services_controller.dart';

class ServicesBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ServicesController(parser: Get.find()),
    );
  }
}

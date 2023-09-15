import 'package:get/get.dart';
import 'package:homeservice/app/controller/find_location_controller.dart';

class FindLocationBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => FindLocationController(parser: Get.find()),
    );
  }
}
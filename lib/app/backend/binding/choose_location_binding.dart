import 'package:get/get.dart';
import 'package:homeservice/app/controller/choose_location_controller.dart';

class ChooseLocationBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ChooseLocationController(parser: Get.find()),
    );
  }
}

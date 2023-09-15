import 'package:get/get.dart';
import 'package:homeservice/app/controller/slider_controller.dart';

class SliderBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SliderController(parser: Get.find()),
    );
  }
}

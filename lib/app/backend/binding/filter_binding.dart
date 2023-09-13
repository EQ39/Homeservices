import 'package:get/get.dart';
import 'package:homeservice/app/controller/filter_controller.dart';

class FilterBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => FilterController(parser: Get.find()),
    );
  }
}

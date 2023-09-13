import 'package:get/get.dart';
import 'package:homeservice/app/controller/refer_controller.dart';

class ReferBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ReferController(parser: Get.find()),
    );
  }
}

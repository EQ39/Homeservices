import 'package:get/get.dart';
import 'package:homeservice/app/controller/checkout_controller.dart';

class CheckoutBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => CheckoutController(parser: Get.find()),
    );
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/controller/stripe_pay_controller.dart';

class StripePayBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => StripePayController(parser: Get.find()),
    );
  }
}

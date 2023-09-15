import 'package:get/get.dart';
import 'package:homeservice/app/controller/cart_controller.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => CartController(parser: Get.find()),
    );
  }
}

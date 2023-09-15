import 'package:get/get.dart';
import 'package:homeservice/app/controller/splash_controller.dart';

class SplashBinging extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SplashScreenController(parser: Get.find()),
    );
  }
}

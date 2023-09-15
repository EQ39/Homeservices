import 'package:get/get.dart';
import 'package:homeservice/app/controller/welcome_controller.dart';

class WelcomeBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => WelcomeController(parser: Get.find()),
    );
  }
}

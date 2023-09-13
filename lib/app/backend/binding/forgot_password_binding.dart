import 'package:get/get.dart';
import 'package:homeservice/app/controller/forgot_password_controller.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ForgotPasswordController(parser: Get.find()),
    );
  }
}

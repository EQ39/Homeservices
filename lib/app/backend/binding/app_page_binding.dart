import 'package:get/get.dart';
import 'package:homeservice/app/controller/app_page_controller.dart';

class AppPageBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AppPageController(parser: Get.find()),
    );
  }
}

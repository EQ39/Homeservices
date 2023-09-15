import 'package:get/get.dart';
import 'package:homeservice/app/controller/popular_controller.dart';

class PopularBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => PopularController(parser: Get.find()),
    );
  }
}

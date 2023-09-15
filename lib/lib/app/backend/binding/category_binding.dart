import 'package:get/get.dart';
import 'package:homeservice/app/controller/category_controller.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => CategoryController(parser: Get.find()),
    );
  }
}

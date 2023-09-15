import 'package:get/get.dart';
import 'package:homeservice/app/controller/subcategory_controller.dart';

class SubcategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SubcategoryController(parser: Get.find()),
    );
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/controller/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => SearchController(parser: Get.find()),
    );
  }
}

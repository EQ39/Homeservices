import 'package:get/get.dart';
import 'package:homeservice/app/controller/favorite_controller.dart';

class FavoriteBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => FavoriteController(parser: Get.find()),
    );
  }
}

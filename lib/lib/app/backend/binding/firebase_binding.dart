import 'package:get/get.dart';
import 'package:homeservice/app/controller/firebase_controller.dart';

class FirebaseBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => FirebaseController(parser: Get.find()),
    );
  }
}

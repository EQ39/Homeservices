import 'package:get/get.dart';


import '../../controller/handyman_profile_controller.dart';

class HandymanProfileBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => HandymanProfileController(parser: Get.find()),
    );
  }
}

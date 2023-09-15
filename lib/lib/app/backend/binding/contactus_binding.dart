import 'package:get/get.dart';
import 'package:homeservice/app/controller/contactus_controller.dart';

class ContactusBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ContactUsController(parser: Get.find()),
    );
  }
}

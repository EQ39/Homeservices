import 'package:get/get.dart';
import 'package:homeservice/app/controller/address_controller.dart';

class AddressBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AddressController(parser: Get.find()),
    );
  }
}

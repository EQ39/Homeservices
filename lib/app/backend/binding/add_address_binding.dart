import 'package:get/get.dart';
import 'package:homeservice/app/controller/add_address_controller.dart';

class AddAddressBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AddAddressController(parser: Get.find()),
    );
  }
}

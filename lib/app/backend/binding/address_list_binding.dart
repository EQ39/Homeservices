import 'package:get/get.dart';
import 'package:homeservice/app/controller/address_list_controller.dart';

class AddressListBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AddressListController(parser: Get.find()),
    );
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/controller/inbox_controller.dart';

class InboxBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => InboxController(parser: Get.find()),
    );
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/controller/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => NotificationController(parser: Get.find()),
    );
  }
}

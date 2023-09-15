import 'package:get/get.dart';
import 'package:homeservice/app/controller/appointment_detail_controller.dart';

class AppointmentDetailBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AppointmentDetailController(parser: Get.find()),
    );
  }
}

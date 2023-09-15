import 'package:get/get.dart';
import 'package:homeservice/app/controller/booking_controller.dart';

class BookingBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => BookingController(parser: Get.find()),
    );
  }
}

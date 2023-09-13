import 'package:get/get.dart';
import 'package:homeservice/app/controller/track_booking_controller.dart';

class TrackBookingBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => TrackBookingController(parser: Get.find()),
    );
  }
}

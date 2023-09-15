import 'package:get/get.dart';
import 'package:homeservice/app/controller/top_freelancers_controller.dart';

class TopFreelancersBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => TopFreelancersController(parser: Get.find()),
    );
  }
}

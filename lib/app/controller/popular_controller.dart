import 'package:get/get.dart';
import 'package:homeservice/app/backend/parse/popular_parse.dart';
import 'package:homeservice/app/controller/homeservice_profile_controller.dart';
import 'package:homeservice/app/helper/router.dart';

import 'handyman_profile_controller.dart';

class PopularController extends GetxController implements GetxService {
  final PopularParser parser;

  bool apiCalled = false;
  PopularController({required this.parser});

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(
      AppRouter.getHandymanProfileRoute(),
      arguments: [id, name],
    );
  }

}

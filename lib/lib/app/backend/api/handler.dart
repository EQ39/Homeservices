import 'package:get/get.dart';
import 'package:homeservice/app/controller/account_controller.dart';
import 'package:homeservice/app/helper/router.dart';
import 'package:homeservice/app/util/toast.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showToast('Session expired!'.tr);
      Get.find<AccountController>().cleanData();
      Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
    } else {
      showToast(response.statusText.toString().tr);
    }
  }
}

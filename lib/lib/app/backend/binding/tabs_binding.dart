import 'package:get/get.dart';
import 'package:homeservice/app/controller/account_controller.dart';
import 'package:homeservice/app/controller/history_controller.dart';
import 'package:homeservice/app/controller/home_controller.dart';
import 'package:homeservice/app/controller/inbox_controller.dart';

import 'package:homeservice/app/controller/tabs_controller.dart';

class TabsBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HomeController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryController(parser: Get.find()), fenix: true);
   // Get.lazyPut(() => ProductCategoryController(parser: Get.find()),
       // fenix: true);
    Get.lazyPut(() => InboxController(parser: Get.find()), fenix: true);
    Get.lazyPut(() => AccountController(parser: Get.find()), fenix: true);
  }
}

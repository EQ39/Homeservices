import 'package:get/get.dart';
import 'package:homeservice/app/controller/wallet_controller.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => WalletController(parser: Get.find()),
    );
  }
}

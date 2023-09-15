import 'package:get/get.dart';
import 'package:homeservice/app/controller/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => ChatController(parser: Get.find()),
    );
  }
}

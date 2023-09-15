import 'package:get/get.dart';
import 'package:homeservice/app/backend/parse/notification_parse.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationParser parser;

  NotificationController({required this.parser});
}

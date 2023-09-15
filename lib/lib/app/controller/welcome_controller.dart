import 'package:get/get.dart';
import 'package:homeservice/app/backend/parse/welcome_parse.dart';

class WelcomeController extends GetxController implements GetxService {
  final WelcomeParser parser;
  String title = '';
  WelcomeController({required this.parser});
}

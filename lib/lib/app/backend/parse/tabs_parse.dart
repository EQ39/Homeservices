import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class TabsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TabsParser(
      {required this.sharedPreferencesManager, required this.apiService});
}

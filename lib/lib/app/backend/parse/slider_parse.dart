import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class SliderParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SliderParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveLanguage(String code) {
    sharedPreferencesManager.putString('language', code);
  }
}

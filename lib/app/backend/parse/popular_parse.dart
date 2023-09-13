import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class PopularParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  PopularParser(
      {required this.sharedPreferencesManager, required this.apiService});
}

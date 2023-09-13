import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class FilterParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  FilterParser(
      {required this.sharedPreferencesManager, required this.apiService});
}

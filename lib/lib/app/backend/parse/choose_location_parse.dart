import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class ChooseLocationParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ChooseLocationParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveLatLng(var lat, var lng, var address) {
    sharedPreferencesManager.putDouble('lat', lat);
    sharedPreferencesManager.putDouble('lng', lng);
    sharedPreferencesManager.putString('address', address);
  }
}

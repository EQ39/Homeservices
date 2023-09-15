import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class ServicesParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ServicesParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getFreelancerFromCategory(var body) async {
    var response = await apiService.postPublic(
        AppConstants.getFreelancerFromCategory, body);
    return response;
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  double getLat() {
    return sharedPreferencesManager.getDouble('lat') ?? 0.0;
  }

  double getLng() {
    return sharedPreferencesManager.getDouble('lng') ?? 0.0;
  }
}

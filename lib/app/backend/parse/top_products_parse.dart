import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:get/get.dart';

class TopProductsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TopProductsParse(
      {required this.sharedPreferencesManager, required this.apiService});

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  Future<Response> getHomeData(var body) async {
    return await apiService.postPublic(AppConstants.topProducts, body);
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class SubcategoryParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SubcategoryParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getFreelancerServices(var body) async {
    var response =
        await apiService.postPublic(AppConstants.getFreelancerServices, body);
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
}

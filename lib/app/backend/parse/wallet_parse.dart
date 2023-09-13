import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';

class WalletParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  WalletParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getWallet() async {
    var response = await apiService.postPrivate(
        AppConstants.getWalletAmounts,
        {"id": sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }
}

import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class HistoryParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HistoryParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMyAppointments(var body) async {
    var response = await apiService.postPrivate(AppConstants.getMyAppointments,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  String getCurrenySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  String getCurrenySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  bool isLogin() {
    return sharedPreferencesManager.getString('uid') != '' &&
            sharedPreferencesManager.getString('uid') != null
        ? true
        : false;
  }
}

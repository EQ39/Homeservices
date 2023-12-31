import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class StripePayParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  StripePayParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getProfile() async {
    return await apiService.postPrivate(
        AppConstants.getUserProfile,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> createProductOrder(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.createProductOrdedr,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getStripeCards(var id) async {
    return await apiService.postPrivate(AppConstants.getStripeCards, {'id': id},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  Future<Response> createOrder(var param) async {
    return await apiService.postPrivate(AppConstants.createOrder, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> checkout(param) async {
    return await apiService.postPrivate(AppConstants.stripeCheckout, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}

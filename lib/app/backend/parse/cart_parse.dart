import 'dart:convert';

import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/backend/model/services_model.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class CartParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CartParser(
      {required this.sharedPreferencesManager, required this.apiService});

  void saveCart(List<ServiceModel> products) {
    List<String> carts = [];
    for (var cartModel in products) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferencesManager.putStringList('savedCart', carts);
  }

  List<ServiceModel> getCartProducts() {
    List<String>? carts = [];

    if (sharedPreferencesManager.isKeyExists('savedCart') ?? false) {
      carts = sharedPreferencesManager.getStringList('savedCart');
    }
    List<ServiceModel> cartList = <ServiceModel>[];
    carts?.forEach((element) {
      var data = jsonDecode(element);
      cartList.add(ServiceModel.fromJson(data));
    });
    return cartList;
  }

  String getCurrencyCode() {
    return sharedPreferencesManager.getString('currencyCode') ??
        AppConstants.defaultCurrencyCode;
  }

  String getCurrencySide() {
    return sharedPreferencesManager.getString('currencySide') ??
        AppConstants.defaultCurrencySide;
  }

  String getCurrencySymbol() {
    return sharedPreferencesManager.getString('currencySymbol') ??
        AppConstants.defaultCurrencySymbol;
  }

  double shippingPrice() {
    return sharedPreferencesManager.getDouble('shippingPrice') ?? 0.0;
  }

  int getShippingMethod() {
    return sharedPreferencesManager.getInt('shipping') ??
        AppConstants.defaultShippingMethod;
  }

  double freeOrderPrice() {
    return sharedPreferencesManager.getDouble('free') ?? 0.0;
  }

  double getAllowedDeliveryRadius() {
    return sharedPreferencesManager.getDouble('allowDistance') ??
        AppConstants.defaultDeliverRadius;
  }

  double taxOrderPrice() {
    return sharedPreferencesManager.getDouble('tax') ?? 0.0;
  }

  String getEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  String getPhone() {
    return sharedPreferencesManager.getString('phone') ?? '';
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }

  String getFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getAppLogo() {
    return sharedPreferencesManager.getString('appLogo') ?? '';
  }
}

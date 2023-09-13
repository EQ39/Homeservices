import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/language_model.dart';
import 'package:homeservice/app/backend/model/settings_model.dart';
import 'package:homeservice/app/backend/model/support_model.dart';
import 'package:homeservice/app/backend/parse/splash_parse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreenController extends GetxController implements GetxService {
  final SplashScreenParse parser;
  late LanguageModel _defaultLanguage;
  LanguageModel get defaultLanguage => _defaultLanguage;
  late SettingsModel _settingsModel;
  SettingsModel get settinsModel => _settingsModel;

  late SupportModel _supportModel;
  SupportModel get supportModel => _supportModel;
  SplashScreenController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint(value.toString());
      parser.saveDeviceToken(value.toString());
    });
  }

  Future<bool> initSharedData() {
    return parser.initAppSettings();
  }

  Future<bool> getConfigData() async {
    Response response = await parser.getAppSettings();
    bool isSuccess = false;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['data'] != null) {
        dynamic body = myMap["data"];
        if (body['settings'] != null && body['support'] != null) {
          SettingsModel appSettingsInfo =
              SettingsModel.fromJson(body['settings']);
          _settingsModel = appSettingsInfo;

          SupportModel supportModelInfo =
              SupportModel.fromJson(body['support']);
          _supportModel = supportModelInfo;

          parser.saveBasicInfo(
              appSettingsInfo.currencyCode,
              appSettingsInfo.currencySide,
              appSettingsInfo.currencySymbol,
              appSettingsInfo.smsName,
              appSettingsInfo.userVerifyWith,
              appSettingsInfo.userLogin,
              appSettingsInfo.email,
              appSettingsInfo.name,
              appSettingsInfo.deliveryType,
              appSettingsInfo.deliveryCharge,
              appSettingsInfo.tax,
              appSettingsInfo.logo,
              '${supportModelInfo.firstName!} ${supportModelInfo.lastName!}',
              supportModelInfo.id,
              appSettingsInfo.mobile.toString(),
              appSettingsInfo.allowDistance);
          isSuccess = true;
        } else {
          isSuccess = false;
        }
      }
    } else {
      ApiChecker.checkApi(response);
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  String getLanguageCode() {
    return parser.getLanguagesCode();
  }
}

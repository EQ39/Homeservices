import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class BookingParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  BookingParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getSlotsForBookings(var body) async {
    debugPrint('---------');
    debugPrint(body.toString());
    debugPrint('---------');
    var response =
        await apiService.postPublic(AppConstants.getSlotsForBookings, body);
    return response;
  }

  String? isToken() {
    return sharedPreferencesManager.getString('token');
  }

  bool isLogin() {
    return sharedPreferencesManager.getString('uid') != '' &&
            sharedPreferencesManager.getString('uid') != null
        ? true
        : false;
  }
}

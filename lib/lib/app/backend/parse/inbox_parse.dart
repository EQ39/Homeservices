import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';

class InboxParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  InboxParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getChatConversion(var uid) async {
    return await apiService.postPrivate(AppConstants.getChatConversionList,
        {'id': uid}, sharedPreferencesManager.getString('token') ?? '');
  }

  bool haveLoggedIn() {
    return sharedPreferencesManager.getString('uid') != '' &&
            sharedPreferencesManager.getString('uid') != null
        ? true
        : false;
  }
}

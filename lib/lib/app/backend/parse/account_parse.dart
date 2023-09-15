import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';

class AccountParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AccountParser(
      {required this.sharedPreferencesManager, required this.apiService});

  String getUserCover() {
    return sharedPreferencesManager.getString('cover') ?? '';
  }

  String getUserFirstName() {
    return sharedPreferencesManager.getString('first_name') ?? '';
  }

  String getUserLastName() {
    return sharedPreferencesManager.getString('last_name') ?? '';
  }

  String getUserEmail() {
    return sharedPreferencesManager.getString('email') ?? '';
  }

  bool isLogin() {
    return sharedPreferencesManager.getString('uid') != '' &&
            sharedPreferencesManager.getString('uid') != null
        ? true
        : false;
  }

  Future<Response> logout() async {
    return await apiService.logout(
        AppConstants.logout, sharedPreferencesManager.getString('token') ?? '');
  }

  void clearAccount() {
    sharedPreferencesManager.clearKey('first_name');
    sharedPreferencesManager.clearKey('last_name');
    sharedPreferencesManager.clearKey('token');
    sharedPreferencesManager.clearKey('uid');
    sharedPreferencesManager.clearKey('email');
    sharedPreferencesManager.clearKey('cover');
  }
}

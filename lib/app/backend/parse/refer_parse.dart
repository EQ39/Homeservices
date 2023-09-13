import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';

class ReferParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ReferParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getMyCode() async {
    return await apiService.postPrivate(
        AppConstants.getMyReferralCode,
        {'id': sharedPreferencesManager.getString('uid')},
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getName() {
    String firstName = sharedPreferencesManager.getString('first_name') ?? '';
    String lastName = sharedPreferencesManager.getString('last_name') ?? '';
    return '$firstName $lastName';
  }
}

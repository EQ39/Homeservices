import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class AddressParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddressParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getSavedAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.getSavedAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> deleteAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.deleteAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }
}

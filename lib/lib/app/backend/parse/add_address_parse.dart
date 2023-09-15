import 'package:get/get.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';

class AddAddressParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddAddressParse(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> saveAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.saveAddress, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }

  Future<Response> getAddressById(var body) async {
    var response = await apiService.postPrivate(AppConstants.addressById, body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateAddress(var body) async {
    var response = await apiService.postPrivate(AppConstants.updateAddress,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> getLatLngFromAddress(String url) async {
    return await apiService.getOther(url);
  }
}

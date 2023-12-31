import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ComplaintsParser(
      {required this.apiService, required this.sharedPreferencesManager});

  Future<Response> getOrderDetails(var id) async {
    return await apiService.postPrivate(AppConstants.getOrderById, {'id': id},
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> getAppointmentById(var body) async {
    var response = await apiService.postPrivate(AppConstants.getAppointmentById,
        body, sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> uploadImage(XFile data) async {
    return await apiService
        .uploadFiles(AppConstants.uploadImage, [MultipartBody('image', data)]);
  }

  Future<Response> registerComplaints(var param) async {
    return await apiService.postPrivate(AppConstants.registerComplaints, param,
        sharedPreferencesManager.getString('token') ?? '');
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}

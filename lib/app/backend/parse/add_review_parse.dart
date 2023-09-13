import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class AddReviewParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  AddReviewParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getFreelancerByID(var body) async {
    var response =
        await apiService.postPublic(AppConstants.getFreelancerByID, body);
    return response;
  }

  Future<Response> getFreelancerReviews(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.getFreelancerReviews,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> saveReview(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.saveFreelancerReviews,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  Future<Response> updateFreelancerInfo(var body) async {
    var response = await apiService.postPrivate(
        AppConstants.updateFreelancerInfo,
        body,
        sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  String getUID() {
    return sharedPreferencesManager.getString('uid') ?? '';
  }
}

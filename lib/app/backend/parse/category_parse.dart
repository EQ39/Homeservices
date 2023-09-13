import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/api.dart';
import 'package:homeservice/app/helper/shared_pref.dart';
import 'package:homeservice/app/util/constant.dart';

class CategoryParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  CategoryParser(
      {required this.sharedPreferencesManager, required this.apiService});

  Future<Response> getAllCategories() async {
    var response = await apiService.getPublic(AppConstants.getAllCategories);
    return response;
  }
}

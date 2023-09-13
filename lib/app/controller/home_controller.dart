import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/banner_model.dart';
import 'package:homeservice/app/backend/model/category_model.dart';
import 'package:homeservice/app/backend/model/freelancer_model.dart';

import 'package:homeservice/app/backend/parse/home_parse.dart';
import 'package:homeservice/app/controller/homeservice_profile_controller.dart';
import 'package:homeservice/app/controller/search_controller.dart';
import 'package:homeservice/app/controller/services_controller.dart';
import 'package:homeservice/app/controller/top_freelancers_controller.dart';

import 'package:homeservice/app/helper/router.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:homeservice/app/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'handyman_profile_controller.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParser parser;

  bool apiCalled = false;

  List<CategoryModel> _categoryList = <CategoryModel>[];
  List<CategoryModel> get categoryList => _categoryList;

  List<FreelancerModel> _freelancerList = <FreelancerModel>[];
  List<FreelancerModel> get freelancerList => _freelancerList;

  List<BannersModel> _bannersList = <BannersModel>[];
  List<BannersModel> get bannersList => _bannersList;

  // List<ProductModel> _productList = <ProductModel>[];
  // List<ProductModel> get productList => _productList;

  String title = '';

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;
  bool haveData = false;
  HomeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    title = parser.getAddressName();
    getHomeData();
  }

  Future<void> getHomeData() async {
    var response = await parser
        .getHomeData({"lat": parser.getLat(), "lng": parser.getLng()});
    apiCalled = true;
    if (response.statusCode == 200) {
      if (response.body != null) {
        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
        if (myMap['data'] != null &&
            myMap['categories'] != null &&
            myMap['products'] != null) {
          var categories = myMap['categories'];
          var body = myMap['data'];
          //var products = myMap['products'];
          var banners = myMap['banners'];
          haveData = myMap['havedata'];
          _categoryList = [];
          _freelancerList = [];
         // _productList = [];
          _bannersList = [];
          categories.forEach((element) {
            CategoryModel datas = CategoryModel.fromJson(element);
            _categoryList.add(datas);
          });
          body.forEach((element) {
            FreelancerModel datas = FreelancerModel.fromJson(element);
            _freelancerList.add(datas);
          });
         
          banners.forEach((element) {
            BannersModel datas = BannersModel.fromJson(element);
            _bannersList.add(datas);
          });
          debugPrint(_bannersList.length.toString());
    
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  

  void onSearch() {
    Get.delete<SearchController>(force: true);
    Get.toNamed(
      AppRouter.getSearchRoute(),
    );
  }

  void onCategory(int id, String name) {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(
      AppRouter.getServicesRoute(),
      arguments: [id, name],
    );
  }

  void onHandymanProfile(int id, String name) {
    Get.delete<HandymanProfileController>(force: true);
    Get.toNamed(
      AppRouter.getHandymanProfileRoute(),
      arguments: [id, name],
    );
  }

  

  void onBannerClick(int type, String value) {
    debugPrint(type.toString());
    debugPrint(value.toString());
    if (type == 1) {
      debugPrint('category');
      Get.delete<ServicesController>(force: true);
      Get.toNamed(
        AppRouter.getServicesRoute(),
        arguments: [int.parse(value.toString()), 'Offers'],
      );
    } else if (type == 2) {
      debugPrint('single freelancer');
      Get.delete<HandymanProfileController>(force: true);
      Get.toNamed(
        AppRouter.getHandymanProfileRoute(),
        arguments: [int.parse(value.toString()), 'Top Freelancer'],
      );
    } else if (type == 3) {
      debugPrint('multiple freelancer');
      Get.delete<TopFreelancersController>(force: true);
      Get.toNamed(AppRouter.getTopFreelancerRoutes(), arguments: [value]);
    }
    
     else {
      debugPrint('external url');
      launchInBrowser(value);
    }
  }

  Future<void> launchInBrowser(var link) async {
    var url = Uri.parse(link);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw '${'Could not launch'.tr} $url';
    }
  }
}

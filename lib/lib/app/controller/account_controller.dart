import 'package:flutter/material.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/parse/account_parse.dart';
import 'package:homeservice/app/controller/address_controller.dart';
import 'package:homeservice/app/controller/app_page_controller.dart';
import 'package:homeservice/app/controller/contactus_controller.dart';
import 'package:homeservice/app/controller/edit_profile_controller.dart';
import 'package:homeservice/app/controller/favorite_controller.dart';
import 'package:homeservice/app/controller/forgot_password_controller.dart';
import 'package:homeservice/app/controller/language_controller.dart';
import 'package:homeservice/app/controller/popular_controller.dart';

import 'package:homeservice/app/controller/tabs_controller.dart';
import 'package:homeservice/app/helper/router.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/util/theme.dart';

class AccountController extends GetxController implements GetxService {
  final AccountParser parser;

  String cover = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  bool login = true;

  bool apiCalled = false;

  AccountController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    login = parser.isLogin();
    cover = parser.getUserCover();
    firstName = parser.getUserFirstName();
    lastName = parser.getUserLastName();
    email = parser.getUserEmail();
    update();
  }

  void updateChanges() {
    login = parser.isLogin();
    cover = parser.getUserCover();
    firstName = parser.getUserFirstName();
    lastName = parser.getUserLastName();
    email = parser.getUserEmail();
    update();
  }

  void onLogin() {
    Get.delete<AccountController>(force: true);
    Get.toNamed(AppRouter.getLoginRoute(), arguments: ['account']);
    // Get.toNamed(AppRouter.getLoginRoute());
  }

  void onEditProfile() {
    Get.delete<EditProfileController>(force: true);
    Get.toNamed(AppRouter.getEditProfileRoute());
  }

  // void onProductHistory() {
  //   Get.delete<ProductHistoryController>(force: true);
  //   Get.toNamed(AppRouter.getProductHistoryRoute());
  // }

  void onAddress() {
    Get.delete<AddressController>(force: true);
    Get.toNamed(AppRouter.getAddressRoute());
  }

  void onFavorite() {
    Get.delete<FavoriteController>(force: true);
    Get.toNamed(AppRouter.getFavoriteRoute());
  }

  void onLanguage() {
    Get.delete<LanguageController>(force: true);
    Get.toNamed(AppRouter.getLanguageRoute());
  }

  void onPopular() {
    Get.delete<PopularController>(force: true);
    Get.toNamed(AppRouter.getPopularRoute());
  }

  void onForgotPassword() {
    Get.delete<ForgotPasswordController>(force: true);
    Get.toNamed(AppRouter.getForgotPasswordRoute());
  }

  void onContactUs() {
    Get.delete<ContactUsController>(force: true);
    Get.toNamed(AppRouter.getContactUsRoute());
  }

  void onChat() {
    Get.find<TabsController>().updateTabId(3);
  }

  void cleanData() {
    login = false;
    parser.clearAccount();
    update();
  }

  Future<void> logout() async {
    Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                  "Please wait".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    Response response = await parser.logout();
    Get.back();
    if (response.statusCode == 200) {
      cleanData();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onAppPages(String name, String id) {
    Get.delete<AppPageController>(force: true);
    Get.toNamed(AppRouter.getAppPageRoute(),
        arguments: [name, id], preventDuplicates: false);
  }
}

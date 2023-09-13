import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/controller/cart_controller.dart';

import 'package:homeservice/app/helper/init.dart';
import 'package:homeservice/app/helper/router.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:homeservice/app/util/theme.dart';
import 'package:homeservice/app/util/translator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MainBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCart();
    // Get.find<CartController>().getCart();
    return GetMaterialApp(
      title: AppConstants.appName,
      color: ThemeProvider.appColor,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      defaultTransition: Transition.native,
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        fontFamily: "regular",
      ),
    );
  }
}

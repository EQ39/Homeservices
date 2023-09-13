import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/helper/router.dart';
import 'package:homeservice/app/util/theme.dart';
import 'package:homeservice/app/widget/elevated_button.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/images/error.png",
                  fit: BoxFit.contain,
                ),
              ),
              Center(
                child: Text('Connection Failed'.tr),
              ),
              Center(
                child: Text('Could not connect to network'.tr),
              ),
              Center(
                child: Text('Please check and try again.'.tr),
              ),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                  onPressed: () {
                    Get.offNamed(AppRouter.getInitialRoute());
                  },
                  color: ThemeProvider.appColor,
                  height: 34,
                  width: 110,
                  child: Text(
                    "retry".tr.toUpperCase(),
                    style: const TextStyle(color: ThemeProvider.whiteColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
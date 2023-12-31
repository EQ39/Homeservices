import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/controller/firebase_controller.dart';
import 'package:homeservice/app/util/constant.dart';
import 'package:homeservice/app/util/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FirebaseVerificationScreen extends StatefulWidget {
  const FirebaseVerificationScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseVerificationScreen> createState() =>
      _FirebaseVerificationScreenState();
}

class _FirebaseVerificationScreenState
    extends State<FirebaseVerificationScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirebaseController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          centerTitle: false,
          title: Text('Verify your phone number'.tr,
              style: ThemeProvider.titleStyle),
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl:
                  '${value.apiURL}${AppConstants.openFirebaseVerification}mobile=${value.countryCode}${value.phoneNumber}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
              onProgress: (int progress) {},
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains('success_verified')) {
                  value.onLogin();
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
              },
              gestureNavigationEnabled: true,
              backgroundColor: ThemeProvider.appColor,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ThemeProvider.whiteColor,
                    ),
                  )
                : Stack(),
          ],
        ),
      );
    });
  }
}

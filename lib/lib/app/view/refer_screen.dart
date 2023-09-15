import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/controller/refer_controller.dart';
import 'package:homeservice/app/util/theme.dart';
import 'package:homeservice/app/widget/elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {

_launchURLApp() async {
  var url = Uri.parse("https://homeservice-freelancer.girlfrombravos.co.ke/");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReferController>(builder: (value) {
      return Scaffold(
        backgroundColor: ThemeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: ThemeProvider.appColor,
          iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Become a Service Provider'.tr,
            style: ThemeProvider.titleStyle,
          ),
        ),
         

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: value.apiCalled == false
              ? const Center(
                  child:
                      CircularProgressIndicator(color: ThemeProvider.appColor),
                )
              : Container(
                  decoration: myBoxDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value.referralData.title.toString(),
                        style: const TextStyle(
                            color: ThemeProvider.backgroundColor,
                            fontFamily: 'bold',
                            fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        value.referralData.message.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: ThemeProvider.backgroundColor, fontSize: 14),
                      ),
                      const SizedBox(height: 14),
                      Image.asset('assets/images/invite.jpg',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.fitHeight),
                      const SizedBox(height: 30),
        //               // Container(
        //               //   decoration: BoxDecoration(
        //               //     border: Border(
        //               //       bottom: BorderSide(
        //               //           color: ThemeProvider.greyColor.shade400),
        //               //     ),
        //               //   ),
        //               //   child: Row(
        //               //     children: [
        //               //       Expanded(
        //               //         child: TextField(
        //               //           enabled: false,
        //               //           decoration: InputDecoration(
        //               //             border: InputBorder.none,
        //               //             hintText: value.myCode.toString(),
        //               //           ),
        //               //         ),
        //               //       ),
        //               //       IconButton(
        //               //           onPressed: () {
        //               //             value.copyToClipBoard();
        //               //           },
        //               //           icon: const Icon(Icons.copy))
        //               //     ],
        //               //   ),
        //               // ),
        //               // const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyElevatedButton(
                          onPressed:  _launchURLApp,
                           
                          height: 45,
                          width: double.infinity,
                          color: ThemeProvider.appColor,
                          child: Text(
                            'Register as a Service Provider'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'medium',
                                fontSize: 16),
                          ),
                        ),
                      )
                    ]
                  ),
                ),
         ),
      );
    });
  }
}

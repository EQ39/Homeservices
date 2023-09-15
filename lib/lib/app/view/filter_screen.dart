import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/controller/filter_controller.dart';
import 'package:homeservice/app/util/theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Filter'.tr,
              style: ThemeProvider.titleStyle,
            ),
          ),
        );
      },
    );
  }
}

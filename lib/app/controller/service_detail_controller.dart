import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/services_model.dart';
import 'package:homeservice/app/backend/parse/service_detail_parse.dart';
import 'package:homeservice/app/controller/cart_controller.dart';
import 'package:homeservice/app/controller/subcategory_controller.dart';
import 'package:homeservice/app/util/constant.dart';

class ServiceDetailController extends GetxController implements GetxService {
  final ServiceDetailParser parser;

  ServiceModel _serviceDetail = ServiceModel();
  ServiceModel get serviceDetail => _serviceDetail;

  String currencySymbol = AppConstants.defaultCurrencySymbol;
  String currencySide = AppConstants.defaultCurrencySide;

  int serviceId = 0;

  bool apiCalled = false;

  ServiceDetailController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    currencySymbol = parser.getCurrenySymbol();
    currencySide = parser.getCurrenySide();
    serviceId = Get.arguments[0];
    debugPrint('freelancer id======= $serviceId');
    getServicesDetail();
  }

  Future<void> getServicesDetail() async {
    var response = await parser.getServicesDetail({"id": serviceId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      _serviceDetail = ServiceModel();
      var body = myMap['data'];
      ServiceModel data = ServiceModel.fromJson(body);
      if (Get.find<CartController>().checkProductInCart(data.id as int)) {
        data.isChecked = true;
      } else {
        data.isChecked = false;
      }
      _serviceDetail = data;
      debugPrint(_serviceDetail.name.toString());

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  void onAddService() {
    _serviceDetail.isChecked = true;
    Get.find<CartController>().addItem(_serviceDetail);
    Get.find<SubcategoryController>().onChangeService();
    update();
  }

  void onRemoveService() {
    _serviceDetail.isChecked = false;
    Get.find<CartController>().removeItem(_serviceDetail);
    Get.find<SubcategoryController>().onChangeService();
    update();
  }
}

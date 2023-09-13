
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/address_model.dart';
import 'package:homeservice/app/backend/parse/address_list_parse.dart';
import 'package:homeservice/app/controller/add_address_controller.dart';
import 'package:homeservice/app/controller/checkout_controller.dart';

import 'package:homeservice/app/helper/router.dart';

class AddressListController extends GetxController implements GetxService {
  final AddressListParser parser;
  String actionFrom = '';

  String selectedAddressId = '';
  List<AddressModel> _addressList = <AddressModel>[];
  List<AddressModel> get addressList => _addressList;
  List<String> titles = ['Home'.tr, 'Work'.tr, 'Others'.tr];

  bool apiCalled = false;

  AddressListController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    actionFrom = Get.arguments[0];
    selectedAddressId = Get.arguments[1];
    getSavedAddress();
  }

  Future<void> getSavedAddress() async {
    var param = {"id": parser.getUID()};

    Response response = await parser.getSavedAddress(param);
    debugPrint(response.bodyString);
    apiCalled = true;
    update();
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      var address = myMap['data'];
      _addressList = [];
      address.forEach((add) {
        AddressModel adds = AddressModel.fromJson(add);
        _addressList.add(adds);
      });
      debugPrint(addressList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveAdd(
    String id,
  ) {
    selectedAddressId = id;

    update();
  }

  void saveAndClose() {
    if (actionFrom == 'service') {
      Get.find<CheckoutController>().onSaveAddress(selectedAddressId);
    }
        onBack();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void onNewAddress() {
    Get.delete<AddAddressController>(force: true);
    Get.toNamed(AppRouter.getAddAddressRoute(), arguments: [actionFrom, 'new']);
  }
}

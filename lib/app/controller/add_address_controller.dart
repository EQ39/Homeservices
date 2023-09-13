import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/address_model.dart';
import 'package:homeservice/app/backend/model/google_address_place_model.dart';
import 'package:homeservice/app/backend/parse/add_address_parse.dart';
import 'package:homeservice/app/controller/address_controller.dart';
import 'package:homeservice/app/controller/address_list_controller.dart';
import 'package:homeservice/app/controller/checkout_controller.dart';
import 'package:homeservice/app/env.dart';

import 'package:homeservice/app/util/theme.dart';
import 'package:homeservice/app/util/toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController implements GetxService {
  final AddAddressParse parser;
  int title = 0;

  final addressTextEditor = TextEditingController();
  final houseTextEditor = TextEditingController();
  final landmarkTextEditor = TextEditingController();
  // final zipcodeTextEditor = TextEditingController();
  int addressId = 0;
  double lat = 0.0;
  double lng = 0.0;
  String action = '';
  List<int> updateAddId = [];
  String fromAction = '';
  AddressModel _addressInfo = AddressModel();
  AddressModel get addressInfo => _addressInfo;
  bool apiCalled = false;
  AddAddressController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    fromAction = Get.arguments[0];
    action = Get.arguments[1];
    if (Get.arguments[1] == 'update') {
      addressId = Get.arguments[2];
      getAddressById();
    } else {
      apiCalled = true;
    }
    getLocation();
  }

  void onFilter(int choice) {
    title = choice;
    update();
  }

  void getLocation() async {
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
                  "Fetching Location".tr,
                  style: const TextStyle(fontFamily: 'bold'),
                )),
              ],
            )
          ],
        ),
        barrierDismissible: false);
    _determinePosition().then((value) async {
      Get.back();
      debugPrint(value.toString());
      List<Placemark> newPlace =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      Placemark placeMark = newPlace[0];
      String name = placeMark.name.toString();
      String subLocality = placeMark.subLocality.toString();
      String locality = placeMark.locality.toString();
      String administrativeArea = placeMark.administrativeArea.toString();
      String postalCode = placeMark.postalCode.toString();
      String country = placeMark.country.toString();
      String address =
          "$name,$subLocality,$locality,$administrativeArea,$postalCode,$country";
      debugPrint(address);

      //   parser.saveLatLng(value.latitude, value.longitude, address);

      //   Get.delete<HomeController>(force: true);
      //   Get.delete<AccountController>(force: true);
      //   Get.delete<HistoryController>(force: true);
      //   Get.delete<InboxController>(force: true);
      // //  Get.delete<ProductHistoryController>(force: true);
      //   Get.offAndToNamed(AppRouter.getTabsRoute());
    }).catchError((error) async {
      Get.back();
      showToast(error.toString());
      await Geolocator.openLocationSettings();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.'.tr);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied'.tr);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.'
              .tr);
    }
    return await Geolocator.getCurrentPosition();
  }

  void getLatLngFromAddress() async {
    if (addressTextEditor.text == '' ||
            addressTextEditor.text.isEmpty ||
            houseTextEditor.text == '' ||
            houseTextEditor.text.isEmpty ||
            landmarkTextEditor.text == '' ||
            landmarkTextEditor.text.isEmpty
        // zipcodeTextEditor.text == '' ||
        // zipcodeTextEditor.text.isEmpty
        ) {
      showToast('All fields are required'.tr);
      return;
    }
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
      barrierDismissible: false,
    );
    var response = await parser.getLatLngFromAddress(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text}&key=${Environments.googleMapsKey}');
    debugPrint(response.bodyString);
    Get.back();
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      GoogleAddresModel address = GoogleAddresModel.fromJson(myMap);
      debugPrint(address.toString());
      if (address.results!.isNotEmpty) {
        debugPrint('ok');
        if (action == 'new') {
          debugPrint('create');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          saveAddress();
        } else {
          debugPrint('update');
          lat = address.results![0].geometry!.location!.lat!;
          lng = address.results![0].geometry!.location!.lng!;
          updateAddress();
        }
      } else {
        showToast("could not determine your location");
        update();
      }
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    // var address =
    //     '${addressTextEditor.text} ${houseTextEditor.text} ${landmarkTextEditor.text}';
    // debugPrint(address);
    // List<Location> locations = await locationFromAddress(address);
    // Get.back();
    // if (locations.isNotEmpty) {
    //   debugPrint(locations[0].toString());
    //   lat = locations[0].latitude;
    //   lng = locations[0].longitude;
    //   update();
    //   if (action == 'new') {
    //     saveAddress();
    //   } else {
    //     updateAddress();
    //   }
    // } else {
    //   Get.back();
    //   showToast("Could not determine your location".tr);
    //   update();
    // }
    // // if (locations.isNotEmpty) {
    // //   debugPrint(locations[0].toString());
    // //   // lat = locations[0].latitude;
    // //   // lng = locations[0].longitude;
    // //   update();
    // if (action == 'new') {
    //   saveAddress();
    // } else {
    //   updateAddress();
    // }
    // // else {
    // //   Get.back();
    // //   showToast("Could not determine your location".tr);
    // //   update();
    // // }
  }

  Future<void> saveAddress() async {
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
      barrierDismissible: false,
    );

    var body = {
      "uid": parser.getUID(),
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": 'NA',
      "lat": lat,
      "lng": lng,
      "status": 1
    };
    var response = await parser.saveAddress(body);
    Get.back();

    debugPrint(response.bodyString);

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Added'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void onBack() {
    if (fromAction == 'list') {
      Get.find<AddressController>().getSavedAddress();
    } else if (fromAction == 'service') {
      Get.find<AddressListController>().getSavedAddress();
      Get.find<CheckoutController>().getSavedAddress();
    } else {
      Get.find<AddressListController>().getSavedAddress();
      // Get.find<ProductCheckoutController>().getSavedAddress();
    }
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  Future<void> getAddressById() async {
    var param = {"id": addressId};

    Response response = await parser.getAddressById(param);
    apiCalled = true;
    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      _addressInfo = AddressModel();
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      AddressModel datas = AddressModel.fromJson(body);
      _addressInfo = datas;
      addressTextEditor.text = _addressInfo.address.toString();
      houseTextEditor.text = _addressInfo.house.toString();
      landmarkTextEditor.text = _addressInfo.landmark.toString();
      // zipcodeTextEditor.text = _addressInfo.pincode.toString();
      title = _addressInfo.title as int;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateAddress() async {
    var body = {
      "title": title,
      "address": addressTextEditor.text,
      "house": houseTextEditor.text,
      "landmark": landmarkTextEditor.text,
      "pincode": 'NA',
      "lat": lat,
      "lng": lng,
      "id": addressId
    };

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
      barrierDismissible: false,
    );

    var response = await parser.updateAddress(body);
    Get.back();

    if (response.statusCode == 200) {
      debugPrint(response.bodyString);
      successToast('Successfully Updated'.tr);
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}

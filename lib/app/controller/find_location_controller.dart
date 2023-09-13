import 'package:flutter/material.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/google_places_model.dart';
import 'package:homeservice/app/backend/parse/find_location_parse.dart';
import 'package:homeservice/app/controller/account_controller.dart';
import 'package:homeservice/app/controller/history_controller.dart';
import 'package:homeservice/app/controller/home_controller.dart';
import 'package:homeservice/app/controller/inbox_controller.dart';

import 'package:homeservice/app/env.dart';
import 'package:homeservice/app/helper/router.dart';
import 'package:homeservice/app/helper/uid_generate.dart';
import 'package:homeservice/app/util/theme.dart';
import 'package:homeservice/app/util/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class FindLocationController extends GetxController implements GetxService {
  final FindLocationParser parser;

  final Set<Marker> markers = {};
  final searchbarText = TextEditingController();
  List<GooglePlacesModel> _getList = <GooglePlacesModel>[];
  List<GooglePlacesModel> get getList => _getList;

  double myLat = 21.5397106;
  double myLng = 71.8215543;

  bool isConfirmed = false;

  FindLocationController({required this.parser});
  @override
  void onInit() {
    super.onInit();
    var pinPosition = LatLng(myLat, myLng);
    markers.add(Marker(
      markerId: const MarkerId('sourcePin'),
      position: pinPosition, // updated position
    ));
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
      parser.saveLatLng(value.latitude, value.longitude, address);

      Get.delete<HomeController>(force: true);
      Get.delete<AccountController>(force: true);
      Get.delete<HistoryController>(force: true);
      Get.delete<InboxController>(force: true);
    //  Get.delete<ProductHistoryController>(force: true);
      Get.offAndToNamed(AppRouter.getTabsRoute());
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

  void onMapCreated(GoogleMapController controller) {
    markers.add(
      const Marker(
        markerId: MarkerId('Id-1'),
        position: LatLng(21.5397106, 71.8215543),
      ),
    );
    update();
  }

  void onSearchChanged(String value) {
    debugPrint(value);
    if (value.isNotEmpty) {
      getPlacesList(value);
    }
  }

  Future<void> getPlacesList(String value) async {
    String googleURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    var sessionToken = Uuid().generateV4();
    var googleKey = Environments.googleMapsKey;
    String request =
        '$googleURL?input=$value&key=$googleKey&sessiontoken=$sessionToken&types=locality';

    '$googleURL?input=$value&key=$Environments.googleMapsKey&sessiontoken=$sessionToken';
    Response response = await parser.getPlacesList(request);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['predictions'];
      _getList = [];
      body.forEach((data) {
        GooglePlacesModel datas = GooglePlacesModel.fromJson(data);
        _getList.add(datas);
      });
      isConfirmed = false;
      update();
      debugPrint(_getList.length.toString());
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getLatLngFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    debugPrint(locations.toString());
    if (locations.isNotEmpty) {
      _getList = [];
      searchbarText.text = address;
      myLat = locations[0].latitude;
      myLng = locations[0].longitude;
      isConfirmed = true;
      var pinPosition = LatLng(myLat, myLng);
      markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: pinPosition, // updated position
      ));
      update();
    }
  }

  void onConfirmLocation() {
    parser.saveLatLng(myLat, myLng, searchbarText.text);
    Get.delete<HomeController>(force: true);
    Get.delete<AccountController>(force: true);
    Get.delete<HistoryController>(force: true);
    Get.delete<InboxController>(force: true);
   // Get.delete<ProductHistoryController>(force: true);
    Get.offAndToNamed(AppRouter.getTabsRoute());
  }
}
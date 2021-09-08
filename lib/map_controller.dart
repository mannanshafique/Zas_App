import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  GoogleMapController? googleMapController;
  Rx<MapType> mapType = MapType.normal.obs;
  static LatLng center = const LatLng(24.8603136, 67.0645627);
  // LatLng test = const LatLng(24.8603136, 67.0645627);
  Rx<LatLng> lastMapPosition = center.obs;
  Position? currentLocation;

  // List<Marker>? markers;
  RxList<Marker> allMarkers = <Marker>[
    Marker(
      draggable: false,
      position: center,
      markerId: MarkerId('origin'),
      infoWindow: InfoWindow.noText,
    ),
  ].obs;

  Set<Marker> markers = Set();

  // final Set<Polyline> polyline = {};
  RxString textAddress = ''.obs;
  RxString deliveryCity = ''.obs;
  RxString deliveryCountry = ''.obs;
  RxString deliveryArea = ''.obs;
  RxDouble addressLat = 0.0.obs;
  RxDouble addressLong = 0.0.obs;

  void onCameraMove(CameraPosition position) {
    lastMapPosition.value = position.target;
    // lastMapPosition.value =
    //     LatLng(currentLocation!.latitude, currentLocation!.longitude);
    // lastMapPosition.value =
    //     LatLng(currentLocation!.latitude, currentLocation!.longitude);
  }

  void animateToDefaultLocation() async {
    // double lat = currentLocation!.latitude;
    // double long = currentLocation!.longitude;
    // print('this is lat $lat');
    // print('this is long $long');
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center,
        // target: LatLng(lat, long),
        // LatLng(currentLocation!.latitude, currentLocation!.latitude),
        zoom: 15.0)));
    List<Placemark> address =
        await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
    textAddress.value = address[0].name.toString() +
        " " +
        address[0].street.toString() +
        " " +
        address[0].subLocality.toString() +
        " " +
        address[0].locality.toString() +
        " " +
        address[0].postalCode.toString() +
        " " +
        address[0].country.toString();
    deliveryCity.value = address[0].locality.toString();
    deliveryCountry.value = address[0].country.toString();
    deliveryArea.value = address[0].subLocality.toString();
    addressLat.value = lastMapPosition.value.latitude;
    addressLong.value = lastMapPosition.value.longitude;
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    // print('this is current position $currentLocation}');
    // print('this is center $center');

    // print(
    //     'this is address name ${address[0].name.toString() + "\n street " + address[0].street.toString() + "\n sub administrative area" + address[0].subAdministrativeArea.toString() + "\n sub locality " + address[0].subLocality.toString() + "\n locality " + address[0].locality.toString() + "\n country " + address[0].country.toString() + "\n " + address[0].postalCode.toString()}');
    // setMarkers();
  }

  // onMarkerDrag(position) async {
  //   print('this is on drag');
  //   lastMapPosition.value = position;
  //   List<Placemark> address = await placemarkFromCoordinates(
  //       lastMapPosition.value.latitude, lastMapPosition.value.longitude);
  //   textAddress.value = address[0].name.toString() +
  //       " " +
  //       address[0].street.toString() +
  //       " " +
  //       address[0].subLocality.toString() +
  //       " " +
  //       address[0].locality.toString() +
  //       " " +
  //       address[0].postalCode.toString() +
  //       " " +
  //       address[0].country.toString();
  //   print(
  //       'this is address ${address[0].name.toString() + " " + address[0].street.toString() + " " + address[0].subAdministrativeArea.toString() + " " + address[0].subLocality.toString() + " " + address[0].locality.toString() + " " + address[0].country.toString()}');
  //   deliveryCity.value = address[0].locality.toString();
  //   deliveryCountry.value = address[0].country.toString();
  //   deliveryArea.value = address[0].subLocality.toString();
  //   addressLat.value = lastMapPosition.value.latitude;
  //   addressLong.value = lastMapPosition.value.longitude;
  //   // setMarkers();
  // }

  navigateTo(routeName) {
    getUserCurrentLocation();
    Get.toNamed(routeName);
    // animateToDefaultLocation();
    // _determinePosition();
  }

  setMarkers() {
    markers.clear();
    markers.add(
      Marker(
        onDragEnd: ((val) {
          // print('lkjhj');
          // onMarkerDrag(val);
        }),
        draggable: false,
        position: lastMapPosition.value,
        markerId: MarkerId('origin'),
        onTap: () async {
          List<Placemark> address =
              await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
          textAddress.value = address[0].name.toString() +
              " " +
              address[0].street.toString() +
              " " +
              address[0].subLocality.toString() +
              " " +
              address[0].locality.toString() +
              " " +
              address[0].postalCode.toString() +
              " " +
              address[0].country.toString();
        },
        infoWindow: InfoWindow.noText,
      ),
    );
    // allMarkers.map((element) => return Set<Marker>());
    return markers;
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Fluttertoast.showToast(msg: 'Location services are disabled.');
      // return Future.error('Location services are disabled.');
      print('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are disabled');
        // Fluttertoast.showToast(msg: 'Location permissions are denied');
        // return Future.error('Location permissions are denied');
      }
    }
    currentLocation = await Geolocator.getCurrentPosition();
    List<Placemark> address =
        await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
    textAddress.value = address[0].name.toString() +
        " " +
        address[0].street.toString() +
        " " +
        address[0].subLocality.toString() +
        " " +
        address[0].locality.toString() +
        " " +
        address[0].postalCode.toString() +
        " " +
        address[0].country.toString();
    // print('this is current location $currentLocation');
    // print('this is center $center}');
    return await Geolocator.getCurrentPosition();
  }

  // CameraPosition initialCameraPosition = CameraPosition(target: );

  searchAndNavigate(address) async {
    // print(address);
    try {
      // print(address);
      await locationFromAddress(address).then((value) async {
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(value[0].latitude, value[0].longitude),
            zoom: 20,
          ),
        ));
        addressLat.value = value[0].latitude;
        addressLong.value = value[0].longitude;
        // lastMapPosition.value = LatLng(value[0].latitude, value[0].longitude);
        // textAddress.value = await placemarkFromCoordinates(LatLng(latitude, longitude));
        List<Placemark> address =
            await placemarkFromCoordinates(value[0].latitude, value[0].longitude);
        textAddress.value = address[0].name.toString() +
            " " +
            address[0].street.toString() +
            " " +
            address[0].subLocality.toString() +
            " " +
            address[0].locality.toString() +
            " " +
            address[0].postalCode.toString() +
            " " +
            address[0].country.toString();
        deliveryCity.value = address[0].locality.toString();
        deliveryCountry.value = address[0].country.toString();
        deliveryArea.value = address[0].subLocality.toString();
        // setMarkers();
        // setMarkers(LatLng(value[0].latitude, value[0].latitude), address);
      });
    } catch (e) {
      // return Fluttertoast.showToast(msg: 'No such location');
      print('No such location');
    }
  }

  Future<void> makePhoneCall(String url) async {
    // if (await canLaunch('tel:$url')) {
    //   await launch('tel:$url');
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  switchMapType() {
    mapType.value = mapType.value == MapType.normal ? MapType.satellite : MapType.normal;
    // getRiderDetailsFromServer();
  }

  @override
  void onInit() async {
    super.onInit();
    // _determinePosition();
  }

  // getRiderDetailsFromServer() async {
  //   print('get rider details executed');
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // String orderId = sharedPreferences.getString(orderNumber);
  //   String orderId = sharedPreferences.getString('orderNumber').toString();
  //   String orderStatus = sharedPreferences.getString('orderStatus').toString();
  //   print('this is orderId $orderId');
  //   print('this is order status $orderStatus');
  //   var response = await Network.assignOrderToRider(
  //     "http://165.227.69.207/rehmat-e-sheree/public/api/",
  //     'orders/rider-details/store',
  //     RiderDetailModel(
  //         riderId: '1255',
  //         orderNo: orderId,
  //         contract: '03342061681',
  //         name: 'Taimoor Rider Supervisor',
  //         status: orderStatus),
  //   );
  //   print('this is response ${response.body}');
  // }
}

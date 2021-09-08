import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zas_app/Constants/constants.dart';

class LocationPickerController extends GetxController {
  var loginselectedIndex = 0.obs;
  var notloginselectedIndex = 0.obs;

  var positionCurrent = ''.obs;

  var responses;

  var country = ''.obs;
  var countryCode = ''.obs;
  var city = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  Position? position;
  RxBool isLod = true.obs;

  var isLoading = true.obs;

  List<Marker> markers = <Marker>[].obs;
  GoogleMapController? mapController;
  BitmapDescriptor? mapMaker;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory

    currentPost();
    setCustomMarker();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onLoginUserItemTapped(int index) {
    loginselectedIndex.value = index;
    print(loginselectedIndex);
    update();
  }

  void onOtherItemTapped(int index) {
    notloginselectedIndex.value = index;
    print(notloginselectedIndex);
    update();
  }

  currentPost() async {
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      try {
        updateText(position!);
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print('Presmission Denied');
    }
  }

  updateText(Position newMarkPosition) async {
    List<Placemark> p =
        await placemarkFromCoordinates(newMarkPosition.latitude, newMarkPosition.longitude);

    Placemark place = p[0];

    city.value = place.locality!;
    country.value = place.country!;
    countryCode.value = place.isoCountryCode!;

    latitude.value = newMarkPosition.latitude;
    longitude.value = newMarkPosition.longitude;
    address.value = "${place.name}, ${place.subLocality}, ${place.locality}";
    positionCurrent.value = "${place.name}, ${place.subLocality}, ${place.country}";
    isLod.value = false;
    update();
  }

  //!

  void updatePosition(CameraPosition _position) {
    Position newMarkerPosition =
        Position(latitude: _position.target.latitude, longitude: _position.target.longitude,accuracy: 20.0,altitude:20,speed: 20 ,speedAccuracy: 20,timestamp: DateTime.now(),heading: 20);
    Marker marker = markers[0];

    markers[0] = marker.copyWith(
        positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    updateText(newMarkerPosition);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // print(position.latitude);
    markers.clear();
    markers.add(Marker(
      draggable: true,
      markerId: MarkerId('id101'),
      icon: mapMaker!,
      position: LatLng(position!.latitude, position!.longitude),

      //position: LatLng(22.54,88.34),
    ));
    update();
  }

  void setCustomMarker() async {
    mapMaker =
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), Constants().markerIcon);
  }

 

  //!

//   var positionCurrent = 'Current Location'.obs;
//   //var pickedLocation = ''.obs;
//   Position position;
//   RxBool isLod = true.obs;

//   List<Marker> markers = <Marker>[].obs;
//   GoogleMapController mapController;
//   BitmapDescriptor mapMaker;

//   @override
//   void onInit() {
//     super.onInit();
//     setCustomMarker();
//     currentPost();
//   }

//   // location(value) {
//   //   pickedLocation.value = value.toString();
//   //   update();
//   // }

//   currentPost() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     try {
//       updateText(position);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     // print(position.latitude);
//     markers.add(Marker(
//       draggable: true,
//       markerId: MarkerId('id101'),
//       icon: mapMaker,
//       position: LatLng(position.latitude, position.longitude),

//       //position: LatLng(22.54,88.34),
//     ));
//     update();
//   }

//   void setCustomMarker() async {
//     mapMaker = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), ConstLinks().icPinDelivery);
//   }

//   void placeSearch(Place place) async {
//     Geolocation geolocation = await place.geolocation;
//     mapController
//         .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));

//     mapController
//         .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
//   }

//   void updatePosition(CameraPosition _position) {
//     Position newMarkerPosition = Position(
//         latitude: _position.target.latitude,
//         longitude: _position.target.longitude);
//     Marker marker = markers[0];

//     markers[0] = marker.copyWith(
//         positionParam:
//             LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
//     updateText(newMarkerPosition);
//   }

//   updateText(Position newMarkPosition) async {
//     List<Placemark> p = await placemarkFromCoordinates(
//         newMarkPosition.latitude, newMarkPosition.longitude);

//     Placemark place = p[0];

//     positionCurrent.value =
//         "${place.locality}, ${place.postalCode}, ${place.country}";
//     print('CO ${place.isoCountryCode}');
//     print('Locality ${place.locality}'); //KArachi
//     print('administrativeArea ${place.administrativeArea}'); //Sindh
//     print('country ${place.country}');
//     print('name ${place.name}'); //Hub Dam Road
//     print(
//         'subAdministrativeArea ${place.subAdministrativeArea}'); //Karachi City
//     print('subLocality ${place.subLocality}'); //subLocality Gadap Town
//     print('subThoroughfare ${place.subThoroughfare}');
//     print('thoroughfare ${place.thoroughfare}');
//     // print(place.locality);
//     // print(place.administrativeArea);
//     // print(place.country);
//     // print(place.name);
//     // print(place.street);
//     // print(place.subAdministrativeArea);
//     // print(place.subLocality);
//     // print(place.subThoroughfare);
//     // print(place.thoroughfare);

//     isLod.value = false;
//     update();
//   }

// //------------------------------------------------------------------------

}

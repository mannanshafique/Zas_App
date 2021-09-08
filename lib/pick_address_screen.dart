
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zas_app/map_controller.dart';

class PickAddressScreen extends StatelessWidget {
  //- final OrderScreenController orderScreenController = Get.find();
  // Completer<GoogleMapController> _controller = Completer();
   final MapController mapController = Get.put(MapController());
  //- final CheckOutFormController checkOutFormController = Get.find();
  //-static const String routeName = '/TrackOrderScreen';

  final bool isVisible;
  final RxBool isSearchFocused = true.obs;

  PickAddressScreen({this.isVisible = true});

  final GlobalKey<ScaffoldState> pickAddressKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: pickAddressKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
       
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() => GoogleMap(
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  onMapCreated: (controller) {
                    mapController.googleMapController = controller;
                  },
                  markers: mapController.setMarkers(),
                  myLocationButtonEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: mapController.currentLocation == null
                        ? mapController.lastMapPosition.value
                        : LatLng(mapController.currentLocation!.latitude,
                            mapController.currentLocation!.longitude),
                    zoom: 15.0,
                  ),
                  mapType: mapController.mapType.value,
                  //   markers: _markers,
                  // markers: mapController.setMarkers(),
                  onCameraMove: mapController.onCameraMove,
                )),
            // PrimaryGoogleMap(
            //   mapController: mapController,
            // ),
            Positioned(
              bottom: 70,
              right: Get.width * 0.08,
              child: Container(
                color: Colors.white,
                child: Container(
                  height: Get.height * 0.185,
                  width: Get.width * 0.85,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: true,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 8),
                            child: Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: Text(
                              mapController.textAddress.value.toString(),
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 15,
                left: Get.width * 0.25,
                child: InkWell(
                  onTap: () {
                    // Get.toNamed(CheckOutForm.routeName);
                    // checkOutFormController.deliveryAddress.text =
                    //     mapController.textAddress.value;
                  },
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Center(
                          child: Text(
                        'Confirm Address',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                )),
Container(
                    color: Colors.red,
             
              height: Get.height * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: ListTile(
                        leading: InkWell(
                          onTap: () {
                            pickAddressKey.currentState!.openDrawer();
                          },
                          // child: SvgPicture.asset(
                          //   iconsPath + 'menu_icon.svg',
                          //   color: Colors.white,
                          // ),
                        ),
                        title: const Text(
                          'Track Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            // Get.toNamed(OrderScreen.routeName);
                          },
                          // child: Badge(
                          //     badgeColor: Colors.amber,
                          //     badgeContent: Text(
                          //         '${orderScreenController.getCartListLength.toString()}'),
                          //     child: SvgPicture.asset(
                          //         '${iconsPath}shopping-cart.svg')),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: CheckoutFormField(
                  //     autoFocus: true,
                  //     textInputType: TextInputType.streetAddress,
                  //     textInputAction: TextInputAction.search,
                  //     onFieldSubmitted: (val) {
                  //       mapController.searchAndNavigate(
                  //           checkOutFormController.searchController.text);
                  //     },
                  //     textEditingController:
                  //         checkOutFormController.searchController,
                  //     // onChanged: mapController.searchAndNavigate,
                  //     placeholder: 'Search Here',
                  //     suffixIcon: Icons.search,
                  //     onSaved: (val) {
                  //       mapController.searchAndNavigate(
                  //           checkOutFormController.searchController.text);
                  //     },
                  //     onSuffixIconPressed: () {
                  //       mapController.searchAndNavigate(
                  //           checkOutFormController.searchController.text);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            // SwitchMapTypeButton(
            //   controller: mapController,
            // ),
            // MapRecenterButton(
            //   controller: mapController,
            // ),
          ],
        ),
      ),
    );
  }
}

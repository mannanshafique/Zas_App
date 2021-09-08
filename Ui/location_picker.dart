
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zas_app/Screens/LocationPicker/Controller/location_picker_controller.dart';

// class DeliveryLocation extends StatelessWidget {
//   final deliveryLocationController = Get.find<DeliveryLocationController>();
//   // final deliveryLocationController = Get.put(UserHomePageController());

//   @override
//   Widget build(BuildContext context) {
//     Orientation orientation = MediaQuery.of(context).orientation;

//     return Scaffold(
//       bottomNavigationBar:
//       RaisedButton(
//           onPressed: () {
//         //     SharedPreferences sharedPreferences =
//         //     await SharedPreferences.getInstance();
//         // if (deliveryLocationController.selectedTime.value == 'Time' &&
//         //     deliveryLocationController.selectedDate.value == 'Date') {
//         //       //! Apply Toast
//         //       Fluttertoast.showToast(msg: 'Select Date First',textColor: Colors.white, backgroundColor: Colors.blue );
//         //       print('ERRRRR');

//         // } else {
//         //     sharedPreferences.setString(
//         //       "SchOrderDate", deliveryLocationController.selectedDate.value);
//         //   sharedPreferences.setString(
//         //       "SchOrderTime", deliveryLocationController.selectedTime.value);
//         // }

//         Get.back();
//           },
//           color: ConstWidget().red,
//           textColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Text('DONE'),
//           ),
//         ),

//       backgroundColor: Colors.white,
//       appBar: ConstWidget().appBar2(
//           Text(
//             'Delivery Location',
//             overflow: TextOverflow.visible,
//             style: TextStyle(color: Colors.black, fontSize: 17),
//           ),
//           true,
//           null,
//           [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                   ),
//                   onPressed: () {}),
//             )
//           ],true),
//       body:
//       Stack(
//         // overflow: Overflow.visible,
//         children: [
//             Obx(
//       () => Container(
//         width: double.infinity,
//         child: SearchMapPlaceWidget(
//             hasClearButton: true,
//             placeType: PlaceType.address,
//             apiKey: ConstLinks().apiKey,
//             placeholder: deliveryLocationController.positionCurrent.value,
//             onSelected: deliveryLocationController.placeSearch),
//       ),
//             ),

//           Column(
//             children: [

//               Obx(
//       () => Expanded(
//               child: Container(
//            //  height: Get.height * 0.4,
//             child: deliveryLocationController.isLod.value != true
//                 ? GoogleMap(
//         myLocationButtonEnabled: true,
//         myLocationEnabled: true,

//         // 2
//         initialCameraPosition: CameraPosition(
//             target: LatLng(
//                 deliveryLocationController.position.latitude,
//                 deliveryLocationController.position.longitude),
//             zoom: 18),
//         // 3
//         mapType: MapType.normal,
//         onCameraMove: ((_position) => deliveryLocationController
//             .updatePosition(_position)),
//         // 4
//         onMapCreated: deliveryLocationController.onMapCreated,

//         markers:
//             Set<Marker>.of(deliveryLocationController.markers),
//                   )
//                 : Center(
//         child: CircularProgressIndicator(),
//                   )),
//       ),
//               ),
//               Obx(
//       () => rowCheckBox('As Soon As Possible', Icons.watch_later,
//             deliveryLocationController.isAsapSelected.value, 'Soon'),
//               ),
//               Obx(
//       () => rowCheckBox('Schedule an Order', Icons.calendar_today,
//             deliveryLocationController.isScheduleSelected.value, 'Sch'),
//               ),
//               Obx(() => Visibility(
//             visible: deliveryLocationController.isScheduleSelected.value,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//           // deliveryLocationController.getCalenderDate(isCalenderOpen);
//           // ignore: unrelated_type_equality_checks
//           showDate(context);
//           // deliveryLocationController.getSelectedDate("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
//                     },
//                     child: Obx(() => dateTimeButtons(orientation,
//             "${deliveryLocationController.selectedDate.value.toString()}")),
//                   ),
//                   Container(
//                     height: orientation == Orientation.portrait
//             ? Get.height * 0.045
//             : Get.height * 0.1,
//                     width: 1,
//                     color: Colors.black45,
//                   ),
//                   GestureDetector(
//           onTap: () {
//             if (deliveryLocationController.selectedDate.value !=
//                     null &&
//                 deliveryLocationController.selectedDate.value !=
//                     "Date") {
//               // showTime(context);
//               showTime(context);
//             } else {
//               Get.snackbar(
//                 'Select Date',
//                 'Please Select Date First',
//                 snackPosition: SnackPosition.BOTTOM,
//               );
//             }
//           },
//           child: dateTimeButtons(orientation,
//               deliveryLocationController.selectedTime.value)),
//                 ],
//               ),
//             ),
//         )),
//             ],
//         ),
//         ],
//       )
//     );
//   }

class DeliveryLocation extends StatelessWidget {
  final locationPickerController = Get.put(LocationPickerController());
  // final deliveryLocationController = Get.put(UserHomePageController());

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
                  child: Container(
                    height: Get.height*0.8,
                    child: Column(
            children: [
              Expanded(
                child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Obx(
                        () => Container(

                            //  height: Get.height * 0.4,

                            child: locationPickerController.isLod.value != true
                                ? GoogleMap(
                                    myLocationButtonEnabled: true,
                                    padding: EdgeInsets.only(
                                      top: 60.0,
                                    ),

                                    myLocationEnabled: true,

                                    // 2

                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            locationPickerController
                                                .position!.latitude,
                                            locationPickerController
                                                .position!.longitude),
                                        zoom: 18),

                                    // 3

                                    mapType: MapType.normal,

                                    onCameraMove: ((_position) =>
                                        locationPickerController
                                            .updatePosition(_position)),

                                    // 4

                                    onMapCreated:
                                        locationPickerController.onMapCreated,

                                    markers: Set<Marker>.of(
                                        locationPickerController.markers),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                     
                    ],
                ),
              ),
            
            ],
          ),
                  ),
        ));
  }

}
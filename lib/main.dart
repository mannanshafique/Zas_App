import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zas_app/Screens/HomePage/Ui/homepage_screen_ui.dart';
import 'package:zas_app/pick_address_screen.dart';

import 'Screens/LocationPicker/Ui/location_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: PickAddressScreen(),
    );
  }
}

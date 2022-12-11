import 'package:bill_calculator/pages/meter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
     defaultTransition: Transition.circularReveal,
      title: "Bill Calculator",
      home: MeterList(),
      theme: ThemeData(
        primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.black
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.black)
      ),
    ));

}



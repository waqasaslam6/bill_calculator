import 'package:bill_calculator/models/Meter.dart';
import 'package:bill_calculator/pages/meter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillController extends GetxController{

  var previousMonthUnits = 0.obs;
  var todayReadingUnits = 0.obs;
  var totalUnitsConsumed = 0.obs;
  var meters = <Meter>[].obs;

  TextEditingController referenceNo = TextEditingController();
  TextEditingController meterName = TextEditingController();
  TextEditingController previousReading= TextEditingController();
  TextEditingController currentReading = TextEditingController();


  @override
  void onInit() async{
    super.onInit();
    fetchMeters();
  }

  void fetchMeters ()async{

    final prefs = await SharedPreferences.getInstance();

    final String? metersString = prefs.getString('meters_key');

    if(metersString != null)
      {
        final List<Meter> metersData = Meter.decode(metersString);
        meters.addAll(metersData);
      }

  }

   void addNewMeter() async {
     final prefs = await SharedPreferences.getInstance();
     meters.add(Meter(
         referenceNumber: referenceNo.text,
         meterName: meterName.text,
         meterImage: "assets/meter.png",
         meterOldReading: previousReading.text,
         meterCurrentReading: currentReading.text,

     ));

     final String encodedData = Meter.encode(meters);

     await prefs.setString('meters_key', encodedData);

     referenceNo.clear();
     meterName.clear();
     previousReading.clear();
     currentReading.clear();


     Get.offAll(() => MeterList());

  }

  void deleteMeter(String refNo) async {
    final prefs = await SharedPreferences.getInstance();
    meters.removeWhere((element) => element.referenceNumber == refNo);

    final String encodedData = Meter.encode(meters);

    await prefs.setString('meters_key', encodedData);

    Get.offAll(() => MeterList());

  }

   void calculateUnits(String meterID) async {

    previousMonthUnits.value = int.parse(previousReading.text);
    todayReadingUnits.value = int.parse(currentReading.text);

    totalUnitsConsumed.value = todayReadingUnits.value - previousMonthUnits.value;
  }


}
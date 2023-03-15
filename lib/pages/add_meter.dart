import 'package:bill_calculator/controllers/bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMeter extends StatelessWidget {
  final billController = Get.put(BillController());
  AddMeter({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var submitTextStyle = GoogleFonts.nunito(
        fontSize: 24,
        letterSpacing: 5,
        color: Colors.white,
        fontWeight: FontWeight.w300);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Meter - Bill Calculator"),
      ),
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                  controller: billController.referenceNo,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Reference no is required.';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter Reference Number",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black
                    )
                  )
              ),
              TextFormField(
                  controller: billController.meterName,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Meter name is required.';
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Meter Name",
                    fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black
                      )
                  )
              ),
              TextFormField(
                controller: billController.previousReading,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Previous reading is required.';
                    return null;
                  },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter Previous Month Reading",
                  fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: Colors.black
                    )
                )
              ),
              TextFormField(
                controller: billController.currentReading,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Current reading is required.';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter Current Reading",
                    fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black
                      )
                  )
              ),
              MaterialButton(
                height: 60,
                minWidth: 180,
                color: Colors.black,
                child: Text("Submit".toUpperCase(),
                style: submitTextStyle,),
                onPressed: () {
                  if(_formKey.currentState!.validate())
                    {
                      _formKey.currentState!.save();
                      billController.addNewMeter();
                    }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
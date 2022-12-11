import 'package:bill_calculator/pages/add_meter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bill_calculator/controllers/bill_controller.dart';
import 'package:google_fonts/google_fonts.dart';


class MeterList extends StatelessWidget {
   MeterList({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final BillController billController = Get.put(BillController());

  @override
  Widget build(BuildContext context) {
    var submitTextStyle = GoogleFonts.nunito(
        fontSize: 20,
        letterSpacing: 3,
        color: Colors.white,
        fontWeight: FontWeight.w600);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(() => AddMeter());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Bill Calculator"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          children: [
           Obx(()=> billController.meters.isEmpty ?
            Expanded(
              child: SizedBox(
                  width: Get.width,
                  child: Image.asset("assets/home2.png")),
            ):
            Expanded(
              child: GetX<BillController>(
                builder: (controller) {
                  return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20
                        ),
                        shrinkWrap: true,
                        itemCount: controller.meters.length,
                        itemBuilder: (context, int index)=>
                           InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(controller.meters[index].meterName ?? ""),
                                    content: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                         TextFormField(
                                          controller: billController.previousReading,
                                           decoration: const InputDecoration(
                                             border: OutlineInputBorder(),
                                             focusedBorder: OutlineInputBorder(),
                                             hintText: "Enter Previous Bill Reading",
                                             labelText: "Previous Bill Reading"
                                           ),
                                         ),
                                          const SizedBox(height: 15,),
                                          TextFormField(
                                           controller: billController.currentReading,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(),
                                                hintText: "Enter Current Reading",
                                              labelText: "Current Reading"
                                            ),
                                          ),
                                          const SizedBox(height: 15,),
                                          MaterialButton(
                                            height: 60,
                                            minWidth: 180,
                                            color: Colors.black,
                                            child: Text("Calculate".toUpperCase(),
                                              style: submitTextStyle,),
                                            onPressed: () {
                                              billController.calculateUnits(
                                                  billController.meters[index].referenceNumber ?? ""
                                              );

                                            },
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                              );
                            },
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(),
                                          image: DecorationImage(
                                            image: AssetImage(controller.meters[index].meterImage ?? ""),
                                            scale: 1.5
                                          )
                                        ),
                                      ),
                                    ),
                                   Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(controller.meters[index].meterName  ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),),
                                    )
                                  ],
                        ),
                                Positioned(
                                  right: -10,
                                    top: -10,
                                    child: IconButton(
                                      onPressed: (){
                                        controller.deleteMeter(controller.meters[index].referenceNumber ?? "");
                                      },
                                      icon: const Icon(Icons.close),
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                           )

                  );
                }
              ),
            )
           )],
        ),
      ),
    );
  }
}

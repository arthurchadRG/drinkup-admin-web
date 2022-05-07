import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:admin/screens/show_order/show_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

ScanController scanController = ScanController();
String qrcode = 'Unknown';

class DrinkScanner extends StatelessWidget {
  const DrinkScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScannerController());
    controller.scannerStatus.listen((scannerStatus) {
      if (scannerStatus == ScannerStatus.success) {
        print(controller.order_items);
        scanController.resume();
        Get.to(ShowOrder());
      }
    });

    //controller.getOrder("93EW5J37");

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: EdgeInsets.only(top: 40, left: 10),
            color: Colors.white.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Scan Drinkup QR",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 42.0),
              ],
            ),
          ),
          Expanded(
            child: ScanView(
              controller: scanController,
// custom scan area, if set to 1.0, will scan full area
              scanAreaScale: .7,
              scanLineColor: Colors.orange,
              onCapture: (data) {
                print(data.characters);
                controller.getOrder(data);
                // do something
              },
            ),
          )
        ],
      ),
    ]));
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 90,
          padding: EdgeInsets.only(top: 40),
          color: Colors.white.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Buy A Drink",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          width: 200, // custom wrap size
          height: 200,
          child: ScanView(
            controller: scanController,
// custom scan area, if set to 1.0, will scan full area
            scanAreaScale: .7,
            scanLineColor: Colors.orange,
            onCapture: (data) {
              print(data.characters);
              controller.getOrder(data);
              // do something
            },
          ),
        ),
      ],
    );
  }
}

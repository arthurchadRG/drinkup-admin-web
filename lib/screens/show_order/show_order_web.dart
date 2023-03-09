import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Helpers/UI/DrinkupButton.dart';
import 'drink_entry.dart';

class ShowOrderWeb extends StatelessWidget {
  const ShowOrderWeb({Key? key}) : super(key: key);

  void _redeemAllDrinks() {}
  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitWanderingCubes(
      color: Colors.orange,
      shape: BoxShape.circle,
      size: 50.0,
    );

    final controller = Get.put(ScannerController());

    controller.getOrder(Get.parameters['order_id']!);

    return GetX<ScannerController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    if (controller.scannerStatus.value == ScannerStatus.loading)
                      spinkit,
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          controller.sender_name.toString() +
                              " sent you drinks!",
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 20.0,
                            color: HexColor.fromHex("#1E2843"),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Show the QR code below to a participating Drinkup Location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 15.0,
                            color: HexColor.fromHex("#1E2843"),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Image(
                                  height:
                                      MediaQuery.of(context).size.height / 6.0,
                                  image:
                                      AssetImage("assets/images/success.png")),
                            ),
                            QrImage(
                              data: controller.orderId.value,
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                  itemCount: controller.order_items.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 50, top: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                              controller.order_items[index].name
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 14.0,
                                                color:
                                                    HexColor.fromHex("#1E2843"),
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Spacer(),
                                          Text(
                                              controller
                                                  .order_items[index].count
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'DMSans',
                                                fontSize: 14.0,
                                                color:
                                                    HexColor.fromHex("#1E2843"),
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Row(
                                children: [
                                  Text("Total Price",
                                      style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 14.0,
                                        color: HexColor.fromHex("#A1A6B3"),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Spacer(),
                                  Text(
                                      "\$" + controller.total_amount.toString(),
                                      style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 14.0,
                                        color: HexColor.fromHex("#1E2843"),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Padding(padding: EdgeInsets.only(bottom: 70))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Want to find a location to redeem?",
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 14.0,
                                    color: HexColor.fromHex("#A1A6B3"),
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: SizedBox(
                                height: 50, //height of button
                                width: MediaQuery.of(context).size.width /
                                    1.7, //width of button
                                child: DrinkupButton(
                                    bgColor: "#E1BB3B",
                                    onclick: _redeemAllDrinks,
                                    buttonText: "Download Our App"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}

import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
          body: Stack(
        children: <Widget>[
          Container(
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if (controller.scannerStatus.value == ScannerStatus.loading)
                  spinkit,
                Container(
                    margin: EdgeInsets.all(30),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/card-picture.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(20),
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Column(
                              children: [
                                Image(
                                  width: 80,
                                  image:
                                      AssetImage("assets/images/wrapper.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Text(
                                  "Hey, ${controller.receiver_name.value} you've received a drinkup voucher from ${controller.sender_name.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Show this QR code to redeem your drink",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        QrImage(
                          data: controller.orderId.value,
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                            child: GridView.count(
                          padding: const EdgeInsets.only(left: 30),
                          childAspectRatio: 3,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List<DrinkEntry>.generate(
                              controller.order_items.length, (index) {
                            return DrinkEntry(
                                sku: controller.order_items[index].skuKey,
                                available:
                                    controller.order_items[index].available,
                                order_id: controller.orderId.value,
                                count: controller.order_items[index].count,
                                quantity: controller.order_items[index].count
                                    .toString(),
                                typeOfDrink: controller.order_items[index].name
                                    .toString());
                          }),
                        )),
                      ],
                    ))
              ],
            ),
          )
        ],
      ));
    });
  }
}

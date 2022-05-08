import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'drink_entry.dart';

class ShowOrder extends StatelessWidget {
  ShowOrder({Key? key, required this.location_id}) : super(key: key);

  String location_id;
  void _redeemAllDrinks() {}
  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitWanderingCubes(
      color: Colors.orange,
      shape: BoxShape.circle,
      size: 50.0,
    );

    ScannerController controller = Get.find();

    return GetX<ScannerController>(builder: (controller) {
      return Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
              // ignore: prefer_const_constructors

              ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: EdgeInsets.only(top: 40, left: 10),
                  color: Colors.white.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset('assets/images/back.png'),
                        iconSize: 32,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Voucher",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 42.0),
                    ],
                  ),
                ),
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
                              children: const [
                                Image(
                                  width: 80,
                                  image:
                                      AssetImage("assets/images/wrapper.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "Customer Drink Order:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                                location_id: location_id,
                                typeOfDrink: controller.order_items[index].name
                                    .toString());
                          }),
                        )),
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 50, //height of button
                          width: MediaQuery.of(context).size.width /
                              1.2, //width of button
                          child: Text("Click on a drink to mark as redeemed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ),
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

import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:admin/controllers/show_order/redeem_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrinkEntry extends StatefulWidget {
  DrinkEntry(
      {Key? key,
      this.quantity = "",
      this.typeOfDrink = "",
      this.sku = "",
      this.location_id = "",
      this.order_id = "",
      this.available = 0,
      this.count = 0})
      : super(key: key);

  String quantity;
  String typeOfDrink;
  String sku;
  String location_id;
  String order_id;
  int count;
  int available;

  @override
  _DrinkEntryState createState() => _DrinkEntryState();
}

void redeemSku(dynamic context, String sku, int available, String order_id,
    String location_id) async {
  if (available <= 0) {
    print("Cannot Redeem with sku $sku");
    showAlert(context, "Not available to redeem");
  } else {
    print("Redeem with sku $sku and order id $order_id");

    RedeemController redeemController = Get.find();
    ScannerController scannerController = Get.find();
    DashboardController dashboardController = Get.find();

    redeemController.redeemStatus.listen((redeemStatus) {
      scannerController.getOrder(order_id);
      dashboardController.grabOrders();
    });

    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Confirm',
      desc: 'Redeem 1 $sku',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        redeemController.redeemSku(sku, order_id, location_id);
      },
    )..show();
  }
}

class _DrinkEntryState extends State<DrinkEntry> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => redeemSku(context, widget.sku, widget.available,
          widget.order_id, widget.location_id),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.orange,
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            height: 40,
            width: 40,
            child: Text(widget.available.toString(),
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          SizedBox(width: 10),
          Text(widget.typeOfDrink,
              style: TextStyle(fontSize: 15, color: Colors.black)),
          Spacer()
        ],
      ),
    );
  }
}

import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/dashboard/orders_model.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/scanner/scanner.dart';
import 'package:admin/screens/scanner/scanner_web.dart';
import 'package:admin/screens/show_order/show_order.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:admin/models/dashboard/locations_model.dart' as lm;
import 'package:intl/intl.dart';
import 'package:qrolo/qrolo.dart';
import '../../../constants.dart';
import '../../../Helpers/constants.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class Orders extends StatelessWidget {
  Orders({
    Key? key,
  }) : super(key: key);

  final DashboardController controller = Get.find();

  void grabOrders() async {
    controller.grabOrders();
  }

  @override
  Widget build(BuildContext context) {
    grabOrders();
    return GetX<DashboardController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.grabOrderStatus.value == GrabOrdersStatus.loading)
              spinkit,
            Text(
              "Redeemed Drinks",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            //SearchField(),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Drink"),
                  ),
                  DataColumn(
                    label: Text("Redemption Date"),
                  ),
                  DataColumn(
                    label: Text("Amount"),
                  ),
                  DataColumn(
                    label: Text("Location"),
                  ),
                ],
                rows: List.generate(
                  controller.orders.length,
                  (index) => orderRow(controller.orders[index]),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

DataRow locationRow(lm.Data data, dynamic context) {
  void _openScan(BuildContext context, ScannerController controller) async {
    final code = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        // var height = MediaQuery.of(context).size.height;
        // var width = MediaQuery.of(context).size.width;
        return AlertDialog(
          insetPadding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: const Text('Scan QR Code'),
          content: Container(
            width: 640,
            height: 480,
            child: QRolo(),
          ),
        );
      },
    );

    controller.getOrder(code!);
  }

  void locationTapped(String location_id) {
    if (kIsWeb) {
      final scannerController = Get.put(ScannerController());
      _openScan(context, scannerController);

      scannerController.scannerStatus.listen((scannerStatus) {
        if (scannerStatus == ScannerStatus.success) {
          Get.to(ShowOrder(
            location_id: location_id,
          ));
        }
      });
    } else {
      Get.to(() => DrinkScanner(location_id: location_id));
    }
  }

  return DataRow(
    cells: [
      DataCell(
        GestureDetector(
          onTap: () => locationTapped(data.id),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/drink.svg",
                height: 20,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(data.street),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

DataRow orderRow(Data orderInfo) {
  String parseDate(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dt);

    return formattedDate;
  }

  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/drink.svg",
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(orderInfo.skuKey),
            ),
          ],
        ),
      ),
      DataCell(Text(parseDate(orderInfo.redeemedAt))),
      DataCell(Text(orderInfo.skuPrice.toString())),
      DataCell(Text(orderInfo.locationName)),
    ],
  );
}

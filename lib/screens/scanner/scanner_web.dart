import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/scanner/scanner_controller.dart';
import 'package:admin/screens/show_order/show_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrolo/qrolo.dart';
import 'package:scan/scan.dart';

ScanController scanController = ScanController();
String qrcode = 'Unknown';

class DrinkScannerWeb extends StatelessWidget {
  DrinkScannerWeb({Key? key, required this.location_id}) : super(key: key);

  String location_id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScannerController());

    void _openScan(BuildContext context) async {
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

      print("CODE: $code");

      controller.getOrder(code!);
    }

    controller.scannerStatus.listen((scannerStatus) {
      if (scannerStatus == ScannerStatus.success) {
        Get.to(ShowOrder(
          location_id: location_id,
        ));
      }
    });

    return Container(
      child: Container(
        child: QRolo(),
      ),
    );
  }
}

import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/controllers/login/login_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'components/finance.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  final controller = Get.put(DashboardController());

  void sessionCheck() async {
    var isSessionValid = await controller.checkSession();

    if (!isSessionValid) {
      Get.toNamed("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    sessionCheck();

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      Orders(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
              ],
            )
          ],
        ),
      ),
    );
  }
}

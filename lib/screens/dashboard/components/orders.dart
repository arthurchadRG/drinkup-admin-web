import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/models/dashboard/orders_model.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

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

DataRow orderRow(Data orderInfo) {
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
      DataCell(Text(orderInfo.redeemedAt)),
      DataCell(Text(orderInfo.locationId)),
    ],
  );
}

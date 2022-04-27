import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class FinanceDetails extends StatelessWidget {
  const FinanceDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finance Breakdown",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          StorageInfoCard(
            svgSrc: "assets/icons/drink.svg",
            title: "Orders over \$10",
            amountOfFiles: "",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/drink.svg",
            title: "Orders over \$20",
            amountOfFiles: "",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/drink.svg",
            title: "Orders over \$50",
            amountOfFiles: "",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/drink.svg",
            title: "Orders over \$100",
            amountOfFiles: "",
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}

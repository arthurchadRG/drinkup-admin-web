import 'package:flutter/material.dart';

class DrinkEntry extends StatefulWidget {
  DrinkEntry(
      {Key? key,
      this.quantity = "",
      this.typeOfDrink = "",
      this.sku = "",
      this.order_id = "",
      this.available = 0,
      this.count = 0})
      : super(key: key);

  String quantity;
  String typeOfDrink;
  String sku;
  String order_id;
  int count;
  int available;

  @override
  _DrinkEntryState createState() => _DrinkEntryState();
}

void redeemSku(String sku, int available) async {
  if (available <= 0) {
    print("Cannot Redeem with sku $sku");
  } else {
    print("Redeem with sku $sku");
  }
}

class _DrinkEntryState extends State<DrinkEntry> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => redeemSku(widget.sku, widget.available),
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

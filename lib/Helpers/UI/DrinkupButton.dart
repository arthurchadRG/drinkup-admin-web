import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DrinkupButton extends StatelessWidget {
  DrinkupButton(
      {Key? key,
      required this.buttonText,
      required this.bgColor,
      required this.onclick,
      this.fontSize = 16,
      this.height = 52,
      this.width = double.infinity})
      : super(key: key);

  String buttonText;
  String bgColor;
  Function onclick;
  double width;
  double height;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onclick();
        },
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: HexColor.fromHex(bgColor),
          elevation: 0.0,
          textStyle: TextStyle(
            fontFamily: 'DMSans',
            fontSize: fontSize,
            color: HexColor.fromHex("#FFFFFF"),
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // <-- Radius
          ),
        ),
      ),
    );
  }
}

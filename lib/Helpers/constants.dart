import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

enum LoginStatus { initial, loading, authenticated, failed }

enum SignupStatus { initial, loading, success, failed }

enum CreateLocationStatus { initial, loading, success, failed }

enum GetLocationStatus { initial, loading, success, failed }

enum GrabOrdersStatus { initial, loading, success, failed }

enum ScannerStatus { initial, loading, success, failed }

enum RedeemStatus { initial, loading, success, failed }

final baseUrl = "https://drinkup-be.onrender.com/v1";

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String parseDate(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dt);

    return formattedDate;
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

void showAlert(dynamic context, String message) {
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    padding: EdgeInsets.all(20),
    dialogType: DialogType.NO_HEADER,
    autoDismiss: false,
    onDissmissCallback: (type) {
      Navigator.of(context).pop(type);
    },
    body: Text(message),
  ).show();
}

final spinkit = SpinKitWave(
  color: HexColor.fromHex("#F1C432"),
  size: 50.0,
);

import 'package:admin/screens/main/main_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qrolo/qrolo.dart';
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  void addLocation() {}

  void openQR(context) async {
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
    print(code);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: SizedBox(
                width: 20, child: Image.asset("assets/images/flat_circle.png")),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Voucher Redeemer",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              openQR(context);
            },
          ),
          DrawerListTile(
            title: "Add Location",
            svgSrc: "assets/icons/drink.svg",
            press: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.NO_HEADER,
                body: AddLocation(),
                btnOk: SizedBox(
                    height: 50, //height of button
                    width: 500,
                    //width of button
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                        onPrimary: Colors.orange, // foreground
                      ),
                      onPressed: addLocation,
                      child: Text('Add Location',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                    )),
              ).show();
            },
          ),
          DrawerListTile(
            title: "Logout",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.toNamed('/');
            },
          ),
        ],
      ),
    );
  }
}

class AddLocation extends StatelessWidget {
  const AddLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Please fill out the form below to add a new location',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Street',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'City',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Region',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Postal Code',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Country',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

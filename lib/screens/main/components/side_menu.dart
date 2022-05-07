import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/scanner/scanner.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  final locationNameController = TextEditingController();
  final streetNameController = TextEditingController();
  final citytNameController = TextEditingController();
  final regiontNameController = TextEditingController();
  final postaltNameController = TextEditingController();
  final countryNameController = TextEditingController();

  void addLocation() {
    print(locationNameController.text);
    print(streetNameController.text);
    print(citytNameController.text);
    print(regiontNameController.text);
    print(postaltNameController.text);
    print(countryNameController.text);

    final DashboardController controller = Get.find();

    controller.createLocation(
        locationNameController.text,
        streetNameController.text,
        citytNameController.text,
        regiontNameController.text,
        postaltNameController.text,
        countryNameController.text);
  }

  void openQR(context) async {
    Get.to(() => DrinkScanner());
    /* final code = await showDialog<String?>(
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
    print(code);*/
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
                      autoDismiss: false,
                      onDissmissCallback: (type) {
                        Navigator.of(context).pop(type);
                      },
                      body: AddLocation(
                        nameController: locationNameController,
                        streetNameController: streetNameController,
                        citytNameController: citytNameController,
                        postaltNameController: postaltNameController,
                        countryNameController: countryNameController,
                        regiontNameController: regiontNameController,
                      ),
                      btnOkOnPress: addLocation,
                      btnOkColor: Colors.orange)
                  .show();
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
  AddLocation(
      {Key? key,
      required this.nameController,
      required this.streetNameController,
      required this.citytNameController,
      required this.regiontNameController,
      required this.postaltNameController,
      required this.countryNameController})
      : super(key: key);

  TextEditingController nameController;
  TextEditingController streetNameController;
  TextEditingController citytNameController;
  TextEditingController regiontNameController;
  TextEditingController postaltNameController;
  TextEditingController countryNameController;

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
              controller: nameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Location Name',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              controller: streetNameController,
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
              controller: citytNameController,
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
              controller: regiontNameController,
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
              controller: postaltNameController,
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
              controller: countryNameController,
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

import 'package:admin/Helpers/constants.dart';
import 'package:admin/controllers/dashboard/dashboard_controller.dart';
import 'package:admin/screens/dashboard/components/orders.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/scanner/scanner.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_api_headers/google_api_headers.dart';
import '../../../constants.dart';

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

  void openQR(context, controller) async {
    //Get.to(() => DrinkScanner());

    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      autoDismiss: true,
      onDissmissCallback: (type) {
        Navigator.of(context).pop(type);
      },
      body: LocationRow(
        controller: controller,
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();
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
              if (controller.locations.length > 0) {
                openQR(context, controller);
              } else {
                showAlert(context,
                    "Please add a location in order to redeem drink vouchers");
              }
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
              Get.deleteAll();
              Get.toNamed('/');
            },
          ),
        ],
      ),
    );
  }
}

class LocationRow extends StatelessWidget {
  LocationRow({Key? key, required DashboardController this.controller})
      : super(key: key);

  DashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Please select a location from below"),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Address"),
                ),
              ],
              rows: List.generate(
                controller.locations.length,
                (index) => locationRow(controller.locations[index], context),
              ),
            ),
          )
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
    Future<void> showPlaces() async {
      const kGoogleApiKey = "AIzaSyBfkI01H8BX-c7V-bvFJSNiCWOPkQP0z_U";

      Prediction? p = await PlacesAutocomplete.show(
          context: context,
          apiKey: kGoogleApiKey,
          mode: Mode.overlay, // Mode.fullscreen
          language: "en",
          strictbounds: false,
          proxyBaseUrl:
              "https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api", //required
          radius: 1000,
          region: "ca",
          offset: 0,
          components: [Component(Component.country, "ca")]);

      if (p != null) {
        GoogleMapsPlaces _places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey,
          baseUrl:
              "https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api",
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
        );
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId!);

        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        print("Full address: ${detail.result.formattedAddress}");

        streetNameController.text = detail.result.addressComponents
            .where((element) => element.types.contains("street_number"))
            .first
            .longName;

        streetNameController.text += " ";

        streetNameController.text += detail.result.addressComponents
            .where((element) => element.types.contains("route"))
            .first
            .longName;
        citytNameController.text = detail.result.addressComponents
            .where((element) => element.types.contains("locality"))
            .first
            .longName;
        regiontNameController.text = detail.result.addressComponents
            .where((element) =>
                element.types.contains("administrative_area_level_1"))
            .first
            .longName;

        postaltNameController.text = detail.result.addressComponents
            .where((element) => element.types.contains("postal_code"))
            .first
            .longName;

        countryNameController.text = detail.result.addressComponents
            .where((element) => element.types.contains("country"))
            .first
            .longName;
      }
    }

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
              onTap: () => showPlaces(),
              readOnly: true,
              controller: streetNameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hoverColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 500,
            child: TextField(
              controller: citytNameController,
              readOnly: true,
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
              readOnly: true,
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
              readOnly: true,
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
              readOnly: true,
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

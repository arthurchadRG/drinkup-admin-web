import 'package:admin/Helpers/Network/http_service.dart';
import 'package:admin/Helpers/constants.dart';
import 'package:admin/models/dashboard/orders_model.dart' as om;
import 'package:admin/models/dashboard/locations_model.dart' as lm;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final createLocationStatus = CreateLocationStatus.initial.obs;
  final getLocationStatus = GetLocationStatus.initial.obs;
  final grabOrderStatus = GrabOrdersStatus.initial.obs;

  final orders = <om.Data>[].obs;

  final locations = <lm.Data>[].obs;

  HttpService networkEngine = HttpService();

  void createLocation(String name, String street, String city, String region,
      String postal, String country) async {
    createLocationStatus.value = CreateLocationStatus.loading;
    try {
      print("network thing");

      var response = await networkEngine.createLocation(
          name, street, city, region, postal, country);

      createLocationStatus.value = CreateLocationStatus.success;
      getLocations();
    } catch (e) {
      print(e);
      createLocationStatus.value = CreateLocationStatus.failed;
    }
  }

  void getLocations() async {
    getLocationStatus.value = GetLocationStatus.loading;
    try {
      print("network thing");

      var response = await networkEngine.getLocation();

      locations.value = response.data;

      getLocationStatus.value = GetLocationStatus.success;
    } catch (e) {
      print(e);
      getLocationStatus.value = GetLocationStatus.failed;
    }
  }

  void grabOrders() async {
    grabOrderStatus.value = GrabOrdersStatus.loading;
    try {
      print("network thing");

      var response = await networkEngine.grabOrders();

      orders.value = response.data;

      grabOrderStatus.value = GrabOrdersStatus.success;
    } catch (e) {
      print(e);
      grabOrderStatus.value = GrabOrdersStatus.failed;
    }
  }

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    var sessionToken = prefs.getString("barback");

    try {
      if (sessionToken!.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
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

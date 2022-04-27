import 'package:admin/Helpers/Network/http_service.dart';
import 'package:admin/Helpers/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final loginStatus = LoginStatus.initial.obs;

  HttpService networkEngine = HttpService();

  void login(String username, String password) async {
    loginStatus.value = LoginStatus.loading;
    try {
      print("network thing");
      final prefs = await SharedPreferences.getInstance();
      var response = await networkEngine.login(username, password);

      await prefs.setString('retailer_id', response.data.retailerId);
      await prefs.setString('business_name', response.data.businessName);
      await prefs.setString('barback', response.data.barback);

      loginStatus.value = LoginStatus.authenticated;
    } catch (e) {
      print(e);
      loginStatus.value = LoginStatus.failed;
    }
  }
}

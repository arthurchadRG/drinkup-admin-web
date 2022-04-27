import 'package:admin/Helpers/Network/http_service.dart';
import 'package:admin/Helpers/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final signupStatus = SignupStatus.initial.obs;

  HttpService networkEngine = HttpService();

  void signup(String identifier, String secret, String business_name) async {
    signupStatus.value = SignupStatus.loading;
    try {
      print("network thing");
      final prefs = await SharedPreferences.getInstance();
      var response =
          await networkEngine.signup(identifier, secret, business_name);

      await prefs.setString('retailer_id', response.data.id);
      await prefs.setString('business_name', response.data.name);

      signupStatus.value = SignupStatus.success;
    } catch (e) {
      print(e);
      signupStatus.value = SignupStatus.failed;
    }
  }
}

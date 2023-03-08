import 'package:admin/Helpers/Network/http_service.dart';
import 'package:admin/Helpers/constants.dart';
import 'package:admin/models/order_details_model.dart';
import 'package:get/get.dart';

class ScannerController extends GetxController {
  final scannerStatus = ScannerStatus.initial.obs;

  final orderId = "".obs;

  final sender_name = "".obs;
  final receiver_name = "".obs;

  final total_amount = 0.0.obs;

  var order_items = <Items>[].obs;

  HttpService networkEngine = HttpService();

  void getOrder(String id) async {
    scannerStatus.value = ScannerStatus.loading;
    try {
      print("network thing");
      var orderDetails = await networkEngine.getOrder(id);
      orderId.value = orderDetails.data.id;
      sender_name.value = orderDetails.data.senderName;
      receiver_name.value = orderDetails.data.toName;
      total_amount.value = orderDetails.data.totalAmount;
      order_items.value = orderDetails.data.items;
      scannerStatus.value = ScannerStatus.success;
    } catch (e) {
      print(e);
      scannerStatus.value = ScannerStatus.failed;
    }
  }
}

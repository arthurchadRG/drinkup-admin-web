import 'package:admin/Helpers/Network/http_service.dart';
import 'package:admin/Helpers/constants.dart';
import 'package:admin/models/show_order/sku_order.dart';
import 'package:get/get.dart';

class RedeemController extends GetxController {
  final redeemStatus = RedeemStatus.initial.obs;

  HttpService networkEngine = HttpService();

  void redeemSku(String sku_key, String order_id, String location_id) async {
    redeemStatus.value = RedeemStatus.loading;
    try {
      print("network thing");

      List<SkuOrder> orders = <SkuOrder>[];

      orders.add(SkuOrder(1, sku_key));

      var response =
          await networkEngine.redeemItem(orders, order_id, location_id);

      redeemStatus.value = RedeemStatus.success;
    } catch (e) {
      print(e);
      redeemStatus.value = RedeemStatus.failed;
    }
  }
}

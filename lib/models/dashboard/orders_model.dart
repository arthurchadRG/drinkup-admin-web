class OrdersModel {
  OrdersModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final List<Data> data;
  late final Meta meta;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.orderId,
    required this.locationId,
    required this.retailerId,
    required this.skuKey,
    required this.redeemedAt,
  });
  late final int id;
  late final String orderId;
  late final String locationId;
  late final String retailerId;
  late final String skuKey;
  late final String redeemedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    locationId = json['location_id'];
    retailerId = json['retailer_id'];
    skuKey = json['sku_key'];
    redeemedAt = json['redeemed_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_id'] = orderId;
    _data['location_id'] = locationId;
    _data['retailer_id'] = retailerId;
    _data['sku_key'] = skuKey;
    _data['redeemed_at'] = redeemedAt;
    return _data;
  }
}

class Meta {
  Meta();

  Meta.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

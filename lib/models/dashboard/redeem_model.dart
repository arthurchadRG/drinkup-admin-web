class RedeemModel {
  RedeemModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final Data data;
  late final Meta meta;

  RedeemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.buyerId,
    required this.toName,
    required this.toPhone,
    required this.totalAmount,
    required this.currencyCode,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.items,
    required this.toNote,
    required this.senderName,
    this.idempotencyToken,
    this.sheet,
  });
  late final String id;
  late final String buyerId;
  late final String toName;
  late final String toPhone;
  late final double totalAmount;
  late final String currencyCode;
  late final String status;
  late final String updatedAt;
  late final String createdAt;
  late final List<Items> items;
  late final String toNote;
  late final String senderName;
  late final Null idempotencyToken;
  late final Null sheet;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyerId = json['buyer_id'];
    toName = json['to_name'];
    toPhone = json['to_phone'];
    totalAmount = json['total_amount'];
    currencyCode = json['currency_code'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    toNote = json['to_note'];
    senderName = json['sender_name'];
    idempotencyToken = json['idempotency_token'];
    sheet = json['sheet'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['buyer_id'] = buyerId;
    _data['to_name'] = toName;
    _data['to_phone'] = toPhone;
    _data['total_amount'] = totalAmount;
    _data['currency_code'] = currencyCode;
    _data['status'] = status;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['to_note'] = toNote;
    _data['sender_name'] = senderName;
    _data['idempotency_token'] = idempotencyToken;
    _data['sheet'] = sheet;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.orderId,
    required this.skuId,
    required this.skuKey,
    required this.name,
    required this.count,
    required this.createdAt,
    required this.updatedAt,
    required this.available,
    required this.redeemed,
  });
  late final int id;
  late final String orderId;
  late final int skuId;
  late final String skuKey;
  late final String name;
  late final int count;
  late final String createdAt;
  late final String updatedAt;
  late final int available;
  late final int redeemed;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    skuId = json['sku_id'];
    skuKey = json['sku_key'];
    name = json['name'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    available = json['available'];
    redeemed = json['redeemed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_id'] = orderId;
    _data['sku_id'] = skuId;
    _data['sku_key'] = skuKey;
    _data['name'] = name;
    _data['count'] = count;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['available'] = available;
    _data['redeemed'] = redeemed;
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

class RetailerModel {
  RetailerModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final Data data;
  late final Meta meta;

  RetailerModel.fromJson(Map<String, dynamic> json) {
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
    required this.retailerId,
    required this.status,
    required this.street,
    required this.city,
    required this.region,
    required this.postalCode,
    required this.countryCode,
  });
  late final String id;
  late final String retailerId;
  late final String status;
  late final String street;
  late final String city;
  late final String region;
  late final String postalCode;
  late final String countryCode;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    status = json['status'];
    street = json['street'];
    city = json['city'];
    region = json['region'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['retailer_id'] = retailerId;
    _data['status'] = status;
    _data['street'] = street;
    _data['city'] = city;
    _data['region'] = region;
    _data['postal_code'] = postalCode;
    _data['country_code'] = countryCode;

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

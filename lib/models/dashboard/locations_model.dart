class LocationsModel {
  LocationsModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final List<Data> data;
  late final Meta meta;

  LocationsModel.fromJson(Map<String, dynamic> json) {
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
    required this.retailerId,
    required this.status,
    required this.street,
    required this.city,
    required this.region,
    required this.postalCode,
    required this.countryCode,
    this.street2,
    this.street3,
    this.latitude,
    this.longitude,
    this.timezone,
    this.name,
  });
  late final String id;
  late final String retailerId;
  late final String status;
  late final String street;
  late final String city;
  late final String region;
  late final String postalCode;
  late final String countryCode;
  late final Null street2;
  late final Null street3;
  late final Null latitude;
  late final Null longitude;
  late final Null timezone;
  late final Null name;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerId = json['retailer_id'];
    status = json['status'];
    street = json['street'];
    city = json['city'];
    region = json['region'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
    street2 = json['street2'];
    street3 = json['street3'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    name = json['name'];
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
    _data['street2'] = street2;
    _data['street3'] = street3;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['timezone'] = timezone;
    _data['name'] = name;
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

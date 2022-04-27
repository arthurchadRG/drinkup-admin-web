class LoginModel {
  LoginModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final Data data;
  late final Meta meta;

  LoginModel.fromJson(Map<String, dynamic> json) {
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
    required this.status,
    required this.joined,
    required this.businessName,
    required this.barback,
    required this.retailerId,
  });
  late final String id;
  late final String status;
  late final String joined;
  late final String businessName;
  late final String barback;
  late final String retailerId;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    joined = json['joined'];
    businessName = json['business_name'];
    barback = json['barback'];
    retailerId = json['retailer_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['joined'] = joined;
    _data['business_name'] = businessName;
    _data['barback'] = barback;
    _data['retailer_id'] = retailerId;
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

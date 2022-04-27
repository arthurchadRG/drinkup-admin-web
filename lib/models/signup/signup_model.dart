class SignupModel {
  SignupModel({
    required this.status,
    required this.data,
    required this.meta,
  });
  late final String status;
  late final Data data;
  late final Meta meta;

  SignupModel.fromJson(Map<String, dynamic> json) {
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
    required this.name,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.notes,
  });
  late final String id;
  late final String name;
  late final String status;
  late final String updatedAt;
  late final String createdAt;
  late final String notes;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    _data['notes'] = notes;
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

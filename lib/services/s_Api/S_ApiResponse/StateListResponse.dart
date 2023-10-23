class StateListResponse {
  bool? status;
  String? message;
  List<StateListData>? data;

  StateListResponse({this.status, this.message, this.data});

  StateListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StateListData>[];
      json['data'].forEach((v) {
        data!.add(StateListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateListData {
  int? id;
  String? name;
  String? countryId;
  String? countryCode;
  String? fipsCode;
  String? iso2;
  String? type;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? flag;
  String? wikiDataId;

  StateListData({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.fipsCode,
    this.iso2,
    this.type,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.flag,
    this.wikiDataId,
  });

  StateListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    countryCode = json['country_code'];
    fipsCode = json['fips_code'];
    iso2 = json['iso2'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['country_code'] = countryCode;
    data['fips_code'] = fipsCode;
    data['iso2'] = iso2;
    data['type'] = type;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wikiDataId'] = wikiDataId;
    return data;
  }
}

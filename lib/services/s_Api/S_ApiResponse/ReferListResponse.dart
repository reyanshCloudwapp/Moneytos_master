class ReferlistResponse {
  bool? status;
  String? message;
  Data? data;

  ReferlistResponse({this.status, this.message, this.data});

  ReferlistResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ReferralData>? referralData;

  Data({this.referralData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['referralData'] != null) {
      referralData = <ReferralData>[];
      json['referralData'].forEach((v) {
        referralData!.add(ReferralData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (referralData != null) {
      data['referralData'] = referralData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferralData {
  int? id;
  String? referredBy;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? status;
  String? isRedeem;
  String? createdAt;
  String? updatedAt;

  ReferralData({
    this.id,
    this.referredBy,
    this.name,
    this.email,
    this.countryCode,
    this.phone,
    this.status,
    this.isRedeem,
    this.createdAt,
    this.updatedAt,
  });

  ReferralData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referredBy = json['referred_by'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    status = json['status'];
    isRedeem = json['is_redeem'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referred_by'] = referredBy;
    data['name'] = name;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['status'] = status;
    data['is_redeem'] = isRedeem;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

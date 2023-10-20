class ReferlistResponse {
  bool? status;
  String? message;
  Data? data;

  ReferlistResponse({this.status, this.message, this.data});

  ReferlistResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
        referralData!.add(new ReferralData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referralData != null) {
      data['referralData'] = this.referralData!.map((v) => v.toJson()).toList();
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

  ReferralData(
      {this.id,
        this.referredBy,
        this.name,
        this.email,
        this.countryCode,
        this.phone,
        this.status,
        this.isRedeem,
        this.createdAt,
        this.updatedAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referred_by'] = this.referredBy;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['is_redeem'] = this.isRedeem;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

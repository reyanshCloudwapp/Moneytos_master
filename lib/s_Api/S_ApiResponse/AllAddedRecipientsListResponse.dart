class AllAddedRecipientsListResponse {
  bool? status;
  String? message;
  Data? data;

  AllAddedRecipientsListResponse({this.status, this.message, this.data});

  AllAddedRecipientsListResponse.fromJson(Map<String, dynamic> json) {
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
  List<Recipientlist>? recipientlist;

  Data({this.recipientlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recipientlist'] != null) {
      recipientlist = <Recipientlist>[];
      json['recipientlist'].forEach((v) {
        recipientlist!.add(new Recipientlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipientlist != null) {
      data['recipientlist'] =
          this.recipientlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipientlist {
  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? countryIso3Code;
  String? countryIso2Code;
  String? phonecode;
  String? phoneNumber;
  String? countryName;
  String? profileImage;
  String? recipientId;
  String? isFavourite;
  String? isDeleted;
  String? relationship;
  String? nameLocalLanguage;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? city;
  String? postcode;
  String? totalAmount;
  String? countryEmoji;
  String? currencyIso3Code;
  String? partnerPaymentMethod;

  Recipientlist(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.countryIso3Code,
        this.countryIso2Code,
        this.phonecode,
        this.phoneNumber,
        this.countryName,
        this.profileImage,
        this.recipientId,
        this.isFavourite,
        this.isDeleted,
        this.relationship,
        this.nameLocalLanguage,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.city,
        this.postcode,
        this.totalAmount,
        this.countryEmoji,
        this.currencyIso3Code,
        this.partnerPaymentMethod
      });

  Recipientlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryIso3Code = json['countryIso3Code'];
    countryIso2Code = json['countryIso2Code'];
    phonecode = json['phonecode'];
    phoneNumber = json['phone_number'];
    countryName = json['country_name'];
    profileImage = json['profileImage'];
    recipientId = json['recipientId'];
    isFavourite = json['is_favourite'];
    isDeleted = json['is_deleted'];
    relationship = json['relationship'];
    nameLocalLanguage = json['name_local_language'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    address = json['address'];
    city = json['city'];
    postcode = json['postcode'];
    totalAmount = json['totalAmount'];
    countryEmoji = json['country_emoji'];
    currencyIso3Code = json['currencyIso3Code'];
    partnerPaymentMethod = json['partner_payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['countryIso3Code'] = this.countryIso3Code;
    data['countryIso2Code'] = this.countryIso2Code;
    data['phonecode'] = this.phonecode;
    data['phone_number'] = this.phoneNumber;
    data['country_name'] = this.countryName;
    data['profileImage'] = this.profileImage;
    data['recipientId'] = this.recipientId;
    data['is_favourite'] = this.isFavourite;
    data['is_deleted'] = this.isDeleted;
    data['relationship'] = this.relationship;
    data['name_local_language'] = this.nameLocalLanguage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address'] = this.address;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['totalAmount'] = this.totalAmount;
    data['country_emoji'] = this.countryEmoji;
    data['currencyIso3Code'] = this.currencyIso3Code;
    data['partner_payment_method'] = this.partnerPaymentMethod;
    return data;
  }
}

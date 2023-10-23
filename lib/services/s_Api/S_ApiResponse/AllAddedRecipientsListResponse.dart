class AllAddedRecipientsListResponse {
  bool? status;
  String? message;
  Data? data;

  AllAddedRecipientsListResponse({this.status, this.message, this.data});

  AllAddedRecipientsListResponse.fromJson(Map<String, dynamic> json) {
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
  List<Recipientlist>? recipientlist;

  Data({this.recipientlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recipientlist'] != null) {
      recipientlist = <Recipientlist>[];
      json['recipientlist'].forEach((v) {
        recipientlist!.add(Recipientlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recipientlist != null) {
      data['recipientlist'] = recipientlist!.map((v) => v.toJson()).toList();
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

  Recipientlist({
    this.id,
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
    this.partnerPaymentMethod,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['countryIso3Code'] = countryIso3Code;
    data['countryIso2Code'] = countryIso2Code;
    data['phonecode'] = phonecode;
    data['phone_number'] = phoneNumber;
    data['country_name'] = countryName;
    data['profileImage'] = profileImage;
    data['recipientId'] = recipientId;
    data['is_favourite'] = isFavourite;
    data['is_deleted'] = isDeleted;
    data['relationship'] = relationship;
    data['name_local_language'] = nameLocalLanguage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address'] = address;
    data['city'] = city;
    data['postcode'] = postcode;
    data['totalAmount'] = totalAmount;
    data['country_emoji'] = countryEmoji;
    data['currencyIso3Code'] = currencyIso3Code;
    data['partner_payment_method'] = partnerPaymentMethod;
    return data;
  }
}

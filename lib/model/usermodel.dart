class UserDataModel {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? address;
  String? country;
  String? state;
  String? city;
  String? isDelete;
  String? emailVerified;
  String? profileImage;
  String? dob;
  String? timezone;
  String? language;
  String? mobileVerify;
  String? accountStatus;
  String? documentStatus;
  String? isPinEnabled;
  String? is_face_enabled;
  String? pin;
  String? magicpay_customer_id;
  String? createdAt;
  String? updatedAt;
  String? authToken;
  String? unique_id;
  String? referral_id;
  String? stepsecstatus;
  int? free_transation;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.countryCode,
    this.address,
    this.country,
    this.state,
    this.city,
    this.isDelete,
    this.emailVerified,
    this.profileImage,
    this.dob,
    this.timezone,
    this.language,
    this.mobileVerify,
    this.accountStatus,
    this.documentStatus,
    this.isPinEnabled,
    this.is_face_enabled,
    this.pin,
    this.magicpay_customer_id,
    this.createdAt,
    this.updatedAt,
    this.authToken,
    this.unique_id,
    this.referral_id,
    this.stepsecstatus,
    this.free_transation,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    isDelete = json['is_delete'];
    emailVerified = json['email_verified'];
    profileImage = json['profileImage'];
    dob = json['dob'];
    timezone = json['timezone'];
    language = json['language'];
    mobileVerify = json['mobile_verify'];
    accountStatus = json['account_status'];
    documentStatus = json['document_status'];
    isPinEnabled = json['is_pin_enabled'];
    is_face_enabled = json['is_face_enabled'];
    pin = json['pin'];
    magicpay_customer_id = json['magicpay_customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    authToken = json['auth_token'];
    unique_id = json['unique_id'];
    referral_id = json['referral_id'];
    stepsecstatus = json['stepsecstatus'];
    free_transation = json['free_transation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['country_code'] = countryCode;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['is_delete'] = isDelete;
    data['email_verified'] = emailVerified;
    data['profileImage'] = profileImage;
    data['dob'] = dob;
    data['timezone'] = timezone;
    data['language'] = language;
    data['mobile_verify'] = mobileVerify;
    data['account_status'] = accountStatus;
    data['document_status'] = documentStatus;
    data['is_pin_enabled'] = isPinEnabled;
    data['is_face_enabled'] = is_face_enabled;
    data['pin'] = pin;
    data['magicpay_customer_id'] = magicpay_customer_id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['auth_token'] = authToken;
    data['unique_id'] = unique_id;
    data['referral_id'] = referral_id;
    data['stepsecstatus'] = stepsecstatus;
    data['free_transation'] = free_transation;
    return data;
  }
}

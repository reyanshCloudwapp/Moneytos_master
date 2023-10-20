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

  UserDataModel(
      {this.id,
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
        this.free_transation});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['country_code'] = this.countryCode;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['is_delete'] = this.isDelete;
    data['email_verified'] = this.emailVerified;
    data['profileImage'] = this.profileImage;
    data['dob'] = this.dob;
    data['timezone'] = this.timezone;
    data['language'] = this.language;
    data['mobile_verify'] = this.mobileVerify;
    data['account_status'] = this.accountStatus;
    data['document_status'] = this.documentStatus;
    data['is_pin_enabled'] = this.isPinEnabled;
    data['is_face_enabled'] = this.is_face_enabled;
    data['pin'] = this.pin;
    data['magicpay_customer_id'] = this.magicpay_customer_id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['auth_token'] = this.authToken;
    data['unique_id'] = this.unique_id;
    data['referral_id'] = this.referral_id;
    data['stepsecstatus'] = this.stepsecstatus;
    data['free_transation'] = this.free_transation;
    return data;
  }
}
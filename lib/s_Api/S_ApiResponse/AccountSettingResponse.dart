class AccountSettingResponse {
  bool? status;
  String? message;
  Data? data;

  AccountSettingResponse({this.status, this.message, this.data});

  AccountSettingResponse.fromJson(Map<String, dynamic> json) {
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
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? uniqueId;
  String? referralId;
  String? name;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zipcode;
  String? isDelete;
  String? emailVerified;
  String? profileImage;
  String? dob;
  String? timezone;
  String? language;
  String? mobileVerify;
  String? accountStatus;
  String? documentStatus;
  String? userDocumentVId;
  String? documentVerifiedAt;
  String? isPinEnabled;
  String? pin;
  String? isBlocked;
  String? blockedReason;
  String? isAppNotifyLoggedin;
  String? isAppNotifyRefferal;
  String? isAppNotifyTxn;
  String? isEmailNotifyLoggedin;
  String? isEmailNotifyRefferal;
  String? isEmailNotifyTxn;
  int? isAppNotifySalesPromotions;
  int? isEmailNotifySalesPromotions;
  String? magicpayCustomerId;
  String? isFaceEnabled;
  int? freeTransation;
  int? usedFreeTransation;
  String? lastLoginAt;
  String? lastLoginAddress;
  String? lastLoginIp;
  String? personaInquiryId;
  String? accountType;
  String? identificationType;
  String? identificationNumber;
  String? sourceOfIncome;
  String? createdAt;
  String? updatedAt;
  String? countryName;
  String? stateName;
  String? stepsecstatus;

  UserData(
      {this.id,
        this.uniqueId,
        this.referralId,
        this.name,
        this.email,
        this.mobileNumber,
        this.countryCode,
        this.address,
        this.country,
        this.state,
        this.city,
        this.zipcode,
        this.isDelete,
        this.emailVerified,
        this.profileImage,
        this.dob,
        this.timezone,
        this.language,
        this.mobileVerify,
        this.accountStatus,
        this.documentStatus,
        this.userDocumentVId,
        this.documentVerifiedAt,
        this.isPinEnabled,
        this.pin,
        this.isBlocked,
        this.blockedReason,
        this.isAppNotifyLoggedin,
        this.isAppNotifyRefferal,
        this.isAppNotifyTxn,
        this.isEmailNotifyLoggedin,
        this.isEmailNotifyRefferal,
        this.isEmailNotifyTxn,
        this.isAppNotifySalesPromotions,
        this.isEmailNotifySalesPromotions,
        this.magicpayCustomerId,
        this.isFaceEnabled,
        this.freeTransation,
        this.usedFreeTransation,
        this.lastLoginAt,
        this.lastLoginAddress,
        this.lastLoginIp,
        this.personaInquiryId,
        this.accountType,
        this.identificationType,
        this.identificationNumber,
        this.sourceOfIncome,
        this.createdAt,
        this.updatedAt,
        this.countryName,
        this.stateName,
        this.stepsecstatus});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    referralId = json['referral_id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    isDelete = json['is_delete'];
    emailVerified = json['email_verified'];
    profileImage = json['profileImage'];
    dob = json['dob'].toString();
    timezone = json['timezone'];
    language = json['language'];
    mobileVerify = json['mobile_verify'];
    accountStatus = json['account_status'];
    documentStatus = json['document_status'];
    userDocumentVId = json['user_document_v_id'];
    documentVerifiedAt = json['document_verified_at'];
    isPinEnabled = json['is_pin_enabled'];
    pin = json['pin'];
    isBlocked = json['is_blocked'];
    blockedReason = json['blocked_reason'];
    isAppNotifyLoggedin = json['is_app_notify_loggedin'];
    isAppNotifyRefferal = json['is_app_notify_refferal'];
    isAppNotifyTxn = json['is_app_notify_txn'];
    isEmailNotifyLoggedin = json['is_email_notify_loggedin'];
    isEmailNotifyRefferal = json['is_email_notify_refferal'];
    isEmailNotifyTxn = json['is_email_notify_txn'];
    isAppNotifySalesPromotions = json['is_app_notify_sales_promotions'];
    isEmailNotifySalesPromotions = json['is_email_notify_sales_promotions'];
    magicpayCustomerId = json['magicpay_customer_id'];
    isFaceEnabled = json['is_face_enabled'];
    freeTransation = json['free_transation'];
    usedFreeTransation = json['used_free_transation'];
    lastLoginAt = json['last_login_at'];
    lastLoginAddress = json['last_login_address'];
    lastLoginIp = json['last_login_ip'];
    personaInquiryId = json['persona_inquiry_id'];
    accountType = json['account_type'].toString();
    identificationType = json['identification_type'].toString();
    identificationNumber = json['identification_number'];
    sourceOfIncome = json['source_of_income'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    stepsecstatus = json['stepsecstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['referral_id'] = this.referralId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['country_code'] = this.countryCode;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    data['is_delete'] = this.isDelete;
    data['email_verified'] = this.emailVerified;
    data['profileImage'] = this.profileImage;
    data['dob'] = this.dob;
    data['timezone'] = this.timezone;
    data['language'] = this.language;
    data['mobile_verify'] = this.mobileVerify;
    data['account_status'] = this.accountStatus;
    data['document_status'] = this.documentStatus;
    data['user_document_v_id'] = this.userDocumentVId;
    data['document_verified_at'] = this.documentVerifiedAt;
    data['is_pin_enabled'] = this.isPinEnabled;
    data['pin'] = this.pin;
    data['is_blocked'] = this.isBlocked;
    data['blocked_reason'] = this.blockedReason;
    data['is_app_notify_loggedin'] = this.isAppNotifyLoggedin;
    data['is_app_notify_refferal'] = this.isAppNotifyRefferal;
    data['is_app_notify_txn'] = this.isAppNotifyTxn;
    data['is_email_notify_loggedin'] = this.isEmailNotifyLoggedin;
    data['is_email_notify_refferal'] = this.isEmailNotifyRefferal;
    data['is_email_notify_txn'] = this.isEmailNotifyTxn;
    data['is_app_notify_sales_promotions'] = this.isAppNotifySalesPromotions;
    data['is_email_notify_sales_promotions'] =
        this.isEmailNotifySalesPromotions;
    data['magicpay_customer_id'] = this.magicpayCustomerId;
    data['is_face_enabled'] = this.isFaceEnabled;
    data['free_transation'] = this.freeTransation;
    data['used_free_transation'] = this.usedFreeTransation;
    data['last_login_at'] = this.lastLoginAt;
    data['last_login_address'] = this.lastLoginAddress;
    data['last_login_ip'] = this.lastLoginIp;
    data['persona_inquiry_id'] = this.personaInquiryId;
    data['account_type'] = this.accountType;
    data['identification_type'] = this.identificationType;
    data['identification_number'] = this.identificationNumber;
    data['source_of_income'] = this.sourceOfIncome;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['stepsecstatus'] = this.stepsecstatus;
    return data;
  }
}

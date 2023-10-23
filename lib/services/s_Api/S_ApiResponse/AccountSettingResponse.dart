class AccountSettingResponse {
  bool? status;
  String? message;
  Data? data;

  AccountSettingResponse({this.status, this.message, this.data});

  AccountSettingResponse.fromJson(Map<String, dynamic> json) {
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
  UserData? userData;

  Data({this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['userData'] = userData!.toJson();
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

  UserData({
    this.id,
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
    this.stepsecstatus,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['referral_id'] = referralId;
    data['name'] = name;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['country_code'] = countryCode;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['is_delete'] = isDelete;
    data['email_verified'] = emailVerified;
    data['profileImage'] = profileImage;
    data['dob'] = dob;
    data['timezone'] = timezone;
    data['language'] = language;
    data['mobile_verify'] = mobileVerify;
    data['account_status'] = accountStatus;
    data['document_status'] = documentStatus;
    data['user_document_v_id'] = userDocumentVId;
    data['document_verified_at'] = documentVerifiedAt;
    data['is_pin_enabled'] = isPinEnabled;
    data['pin'] = pin;
    data['is_blocked'] = isBlocked;
    data['blocked_reason'] = blockedReason;
    data['is_app_notify_loggedin'] = isAppNotifyLoggedin;
    data['is_app_notify_refferal'] = isAppNotifyRefferal;
    data['is_app_notify_txn'] = isAppNotifyTxn;
    data['is_email_notify_loggedin'] = isEmailNotifyLoggedin;
    data['is_email_notify_refferal'] = isEmailNotifyRefferal;
    data['is_email_notify_txn'] = isEmailNotifyTxn;
    data['is_app_notify_sales_promotions'] = isAppNotifySalesPromotions;
    data['is_email_notify_sales_promotions'] = isEmailNotifySalesPromotions;
    data['magicpay_customer_id'] = magicpayCustomerId;
    data['is_face_enabled'] = isFaceEnabled;
    data['free_transation'] = freeTransation;
    data['used_free_transation'] = usedFreeTransation;
    data['last_login_at'] = lastLoginAt;
    data['last_login_address'] = lastLoginAddress;
    data['last_login_ip'] = lastLoginIp;
    data['persona_inquiry_id'] = personaInquiryId;
    data['account_type'] = accountType;
    data['identification_type'] = identificationType;
    data['identification_number'] = identificationNumber;
    data['source_of_income'] = sourceOfIncome;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country_name'] = countryName;
    data['state_name'] = stateName;
    data['stepsecstatus'] = stepsecstatus;
    return data;
  }
}

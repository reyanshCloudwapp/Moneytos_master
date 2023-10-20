class BankListResponse {
  bool? status;
  String? message;
  List<Data>? data;

  BankListResponse({this.status, this.message, this.data});

  BankListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? rid;
  String? uid;
  String? routingCodeType1;
  String? routingCodeValue1;
  String? routingCodeType2;
  String? routingCodeValue2;
  String? accountNumber;
  String? bankAccountType;
  String? bankName;
  String? accountHolder;
  String? bankCode;
  String? mfsBankCode;
  String? deliveryMethodType;
  String? mobileOperator;
  String? partnerPaymentMethod;
  String? jubaNominatedCode;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.rid,
        this.uid,
        this.routingCodeType1,
        this.routingCodeValue1,
        this.routingCodeType2,
        this.routingCodeValue2,
        this.accountNumber,
        this.bankAccountType,
        this.bankName,
        this.accountHolder,
        this.bankCode,
        this.mfsBankCode,
        this.deliveryMethodType,
        this.mobileOperator,
        this.partnerPaymentMethod,
        this.jubaNominatedCode,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rid = json['rid'];
    uid = json['uid'];
    routingCodeType1 = json['routing_code_type_1'];
    routingCodeValue1 = json['routing_code_value_1'];
    routingCodeType2 = json['routing_code_type_2'];
    routingCodeValue2 = json['routing_code_value_2'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bankName = json['bank_name'];
    accountHolder = json['account_holder'];
    bankCode = json['bank_code'];
    mfsBankCode = json['mfs_bank_code'];
    deliveryMethodType = json['delivery_method_type'];
    mobileOperator = json['mobile_operator'];
    partnerPaymentMethod = json['partner_payment_method'];
    jubaNominatedCode = json['juba_NominatedCode'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rid'] = this.rid;
    data['uid'] = this.uid;
    data['routing_code_type_1'] = this.routingCodeType1;
    data['routing_code_value_1'] = this.routingCodeValue1;
    data['routing_code_type_2'] = this.routingCodeType2;
    data['routing_code_value_2'] = this.routingCodeValue2;
    data['account_number'] = this.accountNumber;
    data['bank_account_type'] = this.bankAccountType;
    data['bank_name'] = this.bankName;
    data['account_holder'] = this.accountHolder;
    data['bank_code'] = this.bankCode;
    data['mfs_bank_code'] = this.mfsBankCode;
    data['delivery_method_type'] = this.deliveryMethodType;
    data['mobile_operator'] = this.mobileOperator;
    data['partner_payment_method'] = this.partnerPaymentMethod;
    data['juba_NominatedCode'] = this.jubaNominatedCode;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

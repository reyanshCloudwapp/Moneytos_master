class BankDetailResponse {
  bool? status;
  String? message;
  BankDetailData? data;

  BankDetailResponse({this.status, this.message, this.data});

  BankDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BankDetailData.fromJson(json['data']) : null;
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

class BankDetailData {
  String? rid;
  String? uid;
  String? routingCodeType1;
  String? routingCodeValue1;
  String? routingCodeType2;
  String? routingCodeValue2;
  String? accountNumber;
  String? bankAccountType;
  String? bankName;
  String? bankCode;
  String? updatedAt;
  String? createdAt;
  int? id;

  BankDetailData(
      {this.rid,
        this.uid,
        this.routingCodeType1,
        this.routingCodeValue1,
        this.routingCodeType2,
        this.routingCodeValue2,
        this.accountNumber,
        this.bankAccountType,
        this.bankName,
        this.bankCode,
        this.updatedAt,
        this.createdAt,
        this.id});

  BankDetailData.fromJson(Map<String, dynamic> json) {
    rid = json['rid'];
    uid = json['uid'];
    routingCodeType1 = json['routing_code_type_1'];
    routingCodeValue1 = json['routing_code_value_1'];
    routingCodeType2 = json['routing_code_type_2'];
    routingCodeValue2 = json['routing_code_value_2'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rid'] = this.rid;
    data['uid'] = this.uid;
    data['routing_code_type_1'] = this.routingCodeType1;
    data['routing_code_value_1'] = this.routingCodeValue1;
    data['routing_code_type_2'] = this.routingCodeType2;
    data['routing_code_value_2'] = this.routingCodeValue2;
    data['account_number'] = this.accountNumber;
    data['bank_account_type'] = this.bankAccountType;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

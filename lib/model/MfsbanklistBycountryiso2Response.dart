class MfsbanklistBycountryiso2Response {
  bool? status;
  String? message;
  Data? data;

  MfsbanklistBycountryiso2Response({this.status, this.message, this.data});

  MfsbanklistBycountryiso2Response.fromJson(Map<String, dynamic> json) {
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
  List<Banklist>? banklist;

  Data({this.banklist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banklist'] != null) {
      banklist = <Banklist>[];
      json['banklist'].forEach((v) {
        banklist!.add(new Banklist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banklist != null) {
      data['banklist'] = this.banklist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banklist {
  String? bankName;
  String? bic;
  String? countryCode;
  String? currencyCode;
  String? domBankCode;
  String? iban;
  String? mfsBankCode;

  Banklist(
      {this.bankName,
        this.bic,
        this.countryCode,
        this.currencyCode,
        this.domBankCode,
        this.iban,
        this.mfsBankCode});

  Banklist.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bic = json['bic'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    domBankCode = json['dom_bank_code'];
    iban = json['iban'];
    mfsBankCode = json['mfs_bank_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['bic'] = this.bic;
    data['country_code'] = this.countryCode;
    data['currency_code'] = this.currencyCode;
    data['dom_bank_code'] = this.domBankCode;
    data['iban'] = this.iban;
    data['mfs_bank_code'] = this.mfsBankCode;
    return data;
  }
}

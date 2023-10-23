class MfsbanklistBycountryiso2Response {
  bool? status;
  String? message;
  Data? data;

  MfsbanklistBycountryiso2Response({this.status, this.message, this.data});

  MfsbanklistBycountryiso2Response.fromJson(Map<String, dynamic> json) {
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
  List<Banklist>? banklist;

  Data({this.banklist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banklist'] != null) {
      banklist = <Banklist>[];
      json['banklist'].forEach((v) {
        banklist!.add(Banklist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banklist != null) {
      data['banklist'] = banklist!.map((v) => v.toJson()).toList();
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

  Banklist({
    this.bankName,
    this.bic,
    this.countryCode,
    this.currencyCode,
    this.domBankCode,
    this.iban,
    this.mfsBankCode,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bic'] = bic;
    data['country_code'] = countryCode;
    data['currency_code'] = currencyCode;
    data['dom_bank_code'] = domBankCode;
    data['iban'] = iban;
    data['mfs_bank_code'] = mfsBankCode;
    return data;
  }
}

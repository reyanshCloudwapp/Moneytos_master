class AccountsDetailModel {
  String? dstCurrencyIso3Code;
  String? dstCountryIso3Code;
  String? transferMethod;
  String? recipientAccountId;
  String? accountNumber;
  List<AccountDetailFieldsModel>? fields;

  AccountsDetailModel({
    this.dstCurrencyIso3Code,
    this.dstCountryIso3Code,
    this.transferMethod,
    this.recipientAccountId,
    this.accountNumber,
    this.fields,
  });

  AccountsDetailModel.fromJson(Map<String, dynamic> json) {
    dstCurrencyIso3Code = json['dstCurrencyIso3Code'];
    dstCountryIso3Code = json['dstCountryIso3Code'];
    transferMethod = json['transferMethod'];
    recipientAccountId = json['recipientAccountId'];
    accountNumber = json['accountNumber'];
    if (json['fields'] != null) {
      fields = <AccountDetailFieldsModel>[];
      json['fields'].forEach((v) {
        fields!.add(AccountDetailFieldsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dstCurrencyIso3Code'] = dstCurrencyIso3Code;
    data['dstCountryIso3Code'] = dstCountryIso3Code;
    data['transferMethod'] = transferMethod;
    data['recipientAccountId'] = recipientAccountId;
    data['accountNumber'] = accountNumber;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountDetailFieldsModel {
  String? id;
  String? name;
  String? type;
  String? value;

  AccountDetailFieldsModel({this.id, this.name, this.type, this.value});

  AccountDetailFieldsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}

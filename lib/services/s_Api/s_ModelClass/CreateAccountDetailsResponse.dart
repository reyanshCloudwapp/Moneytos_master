class CreateAccountDetailsResponse {
  String? dstCurrencyIso3Code;
  String? dstCountryIso3Code;
  String? transferMethod;
  String? recipientAccountId;
  String? accountNumber;
  List<CreateAccFields>? fields;

  CreateAccountDetailsResponse({
    this.dstCurrencyIso3Code,
    this.dstCountryIso3Code,
    this.transferMethod,
    this.recipientAccountId,
    this.accountNumber,
    this.fields,
  });

  CreateAccountDetailsResponse.fromJson(Map<String, dynamic> json) {
    dstCurrencyIso3Code = json['dstCurrencyIso3Code'];
    dstCountryIso3Code = json['dstCountryIso3Code'];
    transferMethod = json['transferMethod'];
    recipientAccountId = json['recipientAccountId'];
    accountNumber = json['accountNumber'];
    if (json['fields'] != null) {
      fields = <CreateAccFields>[];
      json['fields'].forEach((v) {
        fields!.add(CreateAccFields.fromJson(v));
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

class CreateAccFields {
  String? id;
  String? name;
  String? type;
  String? value;

  CreateAccFields({this.id, this.name, this.type, this.value});

  CreateAccFields.fromJson(Map<String, dynamic> json) {
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

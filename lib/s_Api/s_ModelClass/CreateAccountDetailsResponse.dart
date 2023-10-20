class CreateAccountDetailsResponse {
  String? dstCurrencyIso3Code;
  String? dstCountryIso3Code;
  String? transferMethod;
  String? recipientAccountId;
  String? accountNumber;
  List<CreateAccFields>? fields;

  CreateAccountDetailsResponse(
      {this.dstCurrencyIso3Code,
        this.dstCountryIso3Code,
        this.transferMethod,
        this.recipientAccountId,
        this.accountNumber,
        this.fields});

  CreateAccountDetailsResponse.fromJson(Map<String, dynamic> json) {
    dstCurrencyIso3Code = json['dstCurrencyIso3Code'];
    dstCountryIso3Code = json['dstCountryIso3Code'];
    transferMethod = json['transferMethod'];
    recipientAccountId = json['recipientAccountId'];
    accountNumber = json['accountNumber'];
    if (json['fields'] != null) {
      fields = <CreateAccFields>[];
      json['fields'].forEach((v) {
        fields!.add(new CreateAccFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dstCurrencyIso3Code'] = this.dstCurrencyIso3Code;
    data['dstCountryIso3Code'] = this.dstCountryIso3Code;
    data['transferMethod'] = this.transferMethod;
    data['recipientAccountId'] = this.recipientAccountId;
    data['accountNumber'] = this.accountNumber;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

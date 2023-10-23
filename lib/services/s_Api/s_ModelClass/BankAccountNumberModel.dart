class BankAccountNumberFieldSetsModel {
  String? fieldSetId;
  String? fieldSetName;
  List<BankAccountsfieldModel>? fields;

  BankAccountNumberFieldSetsModel({
    this.fieldSetId,
    this.fieldSetName,
    this.fields,
  });

  BankAccountNumberFieldSetsModel.fromJson(Map<String, dynamic> json) {
    fieldSetId = json['fieldSetId'];
    fieldSetName = json['fieldSetName'];
    if (json['fields'] != null) {
      fields = <BankAccountsfieldModel>[];
      json['fields'].forEach((v) {
        fields!.add(BankAccountsfieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldSetId'] = fieldSetId;
    data['fieldSetName'] = fieldSetName;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankAccountsfieldModel {
  String? fieldType;
  int? minLength;
  int? maxLength;
  String? regex;
  String? fieldId;
  String? name;
  bool? isRequired;
  String? placeholderText;
  List<BankAccountOptionsModel>? options;
  String? optionsSource;
  String? valueAcc;

  BankAccountsfieldModel({
    this.fieldType,
    this.minLength,
    this.maxLength,
    this.regex,
    this.fieldId,
    this.name,
    this.isRequired,
    this.placeholderText,
    this.options,
    this.optionsSource,
    this.valueAcc,
  });

  BankAccountsfieldModel.fromJson(Map<String, dynamic> json) {
    fieldType = json['fieldType'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
    regex = json['regex'];
    fieldId = json['fieldId'];
    name = json['name'];
    isRequired = json['isRequired'];
    placeholderText = json['placeholderText'];
    if (json['options'] != null) {
      options = <BankAccountOptionsModel>[];
      json['options'].forEach((v) {
        options!.add(BankAccountOptionsModel.fromJson(v));
      });
    }
    optionsSource = json['optionsSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldType'] = fieldType;
    data['minLength'] = minLength;
    data['maxLength'] = maxLength;
    data['regex'] = regex;
    data['fieldId'] = fieldId;
    data['name'] = name;
    data['isRequired'] = isRequired;
    data['placeholderText'] = placeholderText;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['optionsSource'] = optionsSource;
    return data;
  }
}

class BankAccountOptionsModel {
  String? id;
  String? name;

  BankAccountOptionsModel({this.id, this.name});

  BankAccountOptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

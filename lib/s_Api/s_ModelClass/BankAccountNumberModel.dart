class BankAccountNumberFieldSetsModel {
  String? fieldSetId;
  String? fieldSetName;
  List<BankAccountsfieldModel>? fields;

  BankAccountNumberFieldSetsModel({this.fieldSetId, this.fieldSetName, this.fields});

  BankAccountNumberFieldSetsModel.fromJson(Map<String, dynamic> json) {
    fieldSetId = json['fieldSetId'];
    fieldSetName = json['fieldSetName'];
    if (json['fields'] != null) {
      fields = <BankAccountsfieldModel>[];
      json['fields'].forEach((v) {
        fields!.add(new BankAccountsfieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldSetId'] = this.fieldSetId;
    data['fieldSetName'] = this.fieldSetName;
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
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

  BankAccountsfieldModel(
      {this.fieldType,
        this.minLength,
        this.maxLength,
        this.regex,
        this.fieldId,
        this.name,
        this.isRequired,
        this.placeholderText,
        this.options,
        this.optionsSource,
      this.valueAcc});

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
        options!.add(new BankAccountOptionsModel.fromJson(v));
      });
    }
    optionsSource = json['optionsSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldType'] = this.fieldType;
    data['minLength'] = this.minLength;
    data['maxLength'] = this.maxLength;
    data['regex'] = this.regex;
    data['fieldId'] = this.fieldId;
    data['name'] = this.name;
    data['isRequired'] = this.isRequired;
    data['placeholderText'] = this.placeholderText;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['optionsSource'] = this.optionsSource;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
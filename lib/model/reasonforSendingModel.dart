class ReasonForSendingFieldSetsModel {
  String? fieldSetId;
  String? fieldSetName;
  List<ReasongforSendinItemFieldsModel>? fields;

  ReasonForSendingFieldSetsModel({
    this.fieldSetId,
    this.fieldSetName,
    this.fields,
  });

  ReasonForSendingFieldSetsModel.fromJson(Map<String, dynamic> json) {
    fieldSetId = json['fieldSetId'];
    fieldSetName = json['fieldSetName'];
    if (json['fields'] != null) {
      fields = <ReasongforSendinItemFieldsModel>[];
      json['fields'].forEach((v) {
        fields!.add(ReasongforSendinItemFieldsModel.fromJson(v));
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

class ReasongforSendinItemFieldsModel {
  String? fieldType;
  List<ReasonforSendingOptionsModel>? options;
  int? minLength;
  int? maxLength;
  String? fieldId;
  String? name;
  String? hintText;
  bool? isRequired;
  String? placeholderText;

  ReasongforSendinItemFieldsModel({
    this.fieldType,
    this.options,
    this.minLength,
    this.maxLength,
    this.fieldId,
    this.name,
    this.hintText,
    this.isRequired,
    this.placeholderText,
  });

  ReasongforSendinItemFieldsModel.fromJson(Map<String, dynamic> json) {
    fieldType = json['fieldType'];
    if (json['options'] != null) {
      options = <ReasonforSendingOptionsModel>[];
      json['options'].forEach((v) {
        options!.add(ReasonforSendingOptionsModel.fromJson(v));
      });
    }
    minLength = json['minLength'];
    maxLength = json['maxLength'];
    fieldId = json['fieldId'];
    name = json['name'];
    hintText = json['hintText'];
    isRequired = json['isRequired'];
    placeholderText = json['placeholderText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldType'] = fieldType;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['minLength'] = minLength;
    data['maxLength'] = maxLength;
    data['fieldId'] = fieldId;
    data['name'] = name;
    data['hintText'] = hintText;
    data['isRequired'] = isRequired;
    data['placeholderText'] = placeholderText;
    return data;
  }
}

class ReasonforSendingOptionsModel {
  String? id;
  String? name;

  ReasonforSendingOptionsModel({this.id, this.name});

  ReasonforSendingOptionsModel.fromJson(Map<String, dynamic> json) {
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

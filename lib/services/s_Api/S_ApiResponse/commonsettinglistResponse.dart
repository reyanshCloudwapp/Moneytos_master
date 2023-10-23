class CommonsettinglistResponse {
  bool? status;
  String? message;
  Data? data;

  CommonsettinglistResponse({this.status, this.message, this.data});

  CommonsettinglistResponse.fromJson(Map<String, dynamic> json) {
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
  List<CommonData>? commonData;

  Data({this.commonData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['commonData'] != null) {
      commonData = <CommonData>[];
      json['commonData'].forEach((v) {
        commonData!.add(CommonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commonData != null) {
      data['commonData'] = commonData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonData {
  String? slugName;
  String? slugValue;

  CommonData({this.slugName, this.slugValue});

  CommonData.fromJson(Map<String, dynamic> json) {
    slugName = json['slug_name'];
    slugValue = json['slug_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug_name'] = slugName;
    data['slug_value'] = slugValue;
    return data;
  }
}

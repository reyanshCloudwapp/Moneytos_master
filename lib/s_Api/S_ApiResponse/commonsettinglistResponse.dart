class CommonsettinglistResponse {
  bool? status;
  String? message;
  Data? data;

  CommonsettinglistResponse({this.status, this.message, this.data});

  CommonsettinglistResponse.fromJson(Map<String, dynamic> json) {
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
  List<CommonData>? commonData;

  Data({this.commonData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['commonData'] != null) {
      commonData = <CommonData>[];
      json['commonData'].forEach((v) {
        commonData!.add(new CommonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonData != null) {
      data['commonData'] = this.commonData!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug_name'] = this.slugName;
    data['slug_value'] = this.slugValue;
    return data;
  }
}

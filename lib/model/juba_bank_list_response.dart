class JubabanklistBycountryiso2Response {
  bool? status;
  String? message;
  Data? data;

  JubabanklistBycountryiso2Response({this.status, this.message, this.data});

  JubabanklistBycountryiso2Response.fromJson(Map<String, dynamic> json) {
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
  List<JubaBanklist>? banklist;

  Data({this.banklist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banklist'] != null) {
      banklist = <JubaBanklist>[];
      json['banklist'].forEach((v) {
        banklist!.add(new JubaBanklist.fromJson(v));
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

class JubaBanklist {
  String? bankName;
  String? jubaNominatedCode;

  JubaBanklist({this.bankName, this.jubaNominatedCode});

  JubaBanklist.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    jubaNominatedCode = json['juba_NominatedCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['juba_NominatedCode'] = this.jubaNominatedCode;
    return data;
  }
}

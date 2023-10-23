class PurposeCodesResponse {
  bool? status;
  String? message;
  List<PurposeData>? data;

  PurposeCodesResponse({this.status, this.message, this.data});

  PurposeCodesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PurposeData>[];
      json['data'].forEach((v) {
        data!.add(PurposeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurposeData {
  String? id;
  String? purposeCode;
  String? purposeCodeDescription;
  String? tradePurposeCode;
  String? p2P;
  String? remarks;
  String? additionalDetails;
  String? uPIPaymentSupported;
  String? createdAt;
  String? updatedAt;
  int? isShow;

  PurposeData({
    this.id,
    this.purposeCode,
    this.purposeCodeDescription,
    this.tradePurposeCode,
    this.p2P,
    this.remarks,
    this.additionalDetails,
    this.uPIPaymentSupported,
    this.createdAt,
    this.updatedAt,
    this.isShow,
  });

  PurposeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purposeCode = json['Purpose_Code'];
    purposeCodeDescription = json['Purpose_Code_Description'];
    tradePurposeCode = json['Trade_Purpose_Code'];
    p2P = json['P2P'];
    remarks = json['Remarks'];
    additionalDetails = json['Additional_Details'];
    uPIPaymentSupported = json['UPI_Payment_Supported'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Purpose_Code'] = purposeCode;
    data['Purpose_Code_Description'] = purposeCodeDescription;
    data['Trade_Purpose_Code'] = tradePurposeCode;
    data['P2P'] = p2P;
    data['Remarks'] = remarks;
    data['Additional_Details'] = additionalDetails;
    data['UPI_Payment_Supported'] = uPIPaymentSupported;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_show'] = isShow;
    return data;
  }
}

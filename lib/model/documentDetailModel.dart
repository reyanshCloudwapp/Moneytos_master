class DocumentDataDetailModel {
  int? id;
  String? userId;
  String? documentType;
  String? documentId;
  String? ducumentFrontImage;
  String? ducumentBackImage;
  String? documentStatus;
  String? ducumentStatusChangeAt;
  String? rejectReason;
  String? approvedBy;
  String? createdAt;
  String? updatedAt;

  DocumentDataDetailModel({
    this.id,
    this.userId,
    this.documentType,
    this.documentId,
    this.ducumentFrontImage,
    this.ducumentBackImage,
    this.documentStatus,
    this.ducumentStatusChangeAt,
    this.rejectReason,
    this.approvedBy,
    this.createdAt,
    this.updatedAt,
  });

  DocumentDataDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    documentType = json['document_type'];
    documentId = json['document_id'];
    ducumentFrontImage = json['ducument_front_image'];
    ducumentBackImage = json['ducument_back_image'];
    documentStatus = json['document_status'];
    ducumentStatusChangeAt = json['ducument_status_change_at'];
    rejectReason = json['reject_reason'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['document_type'] = documentType;
    data['document_id'] = documentId;
    data['ducument_front_image'] = ducumentFrontImage;
    data['ducument_back_image'] = ducumentBackImage;
    data['document_status'] = documentStatus;
    data['ducument_status_change_at'] = ducumentStatusChangeAt;
    data['reject_reason'] = rejectReason;
    data['approved_by'] = approvedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

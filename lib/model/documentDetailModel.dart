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

  DocumentDataDetailModel(
      {this.id,
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
        this.updatedAt});

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
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['document_type'] = this.documentType;
    data['document_id'] = this.documentId;
    data['ducument_front_image'] = this.ducumentFrontImage;
    data['ducument_back_image'] = this.ducumentBackImage;
    data['document_status'] = this.documentStatus;
    data['ducument_status_change_at'] = this.ducumentStatusChangeAt;
    data['reject_reason'] = this.rejectReason;
    data['approved_by'] = this.approvedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
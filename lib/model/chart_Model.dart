class ChartDataModel {
  String? totalSendAmount;
  List<TxnGraphDataModel>? txnGraphData;
  List<ChartRecipientDataModel>? recipientData;

  ChartDataModel({this.totalSendAmount, this.recipientData});

  ChartDataModel.fromJson(Map<String, dynamic> json) {
    totalSendAmount = json['totalSendAmount'];
    if (json['TxnGraphData'] != null) {
      txnGraphData = <TxnGraphDataModel>[];
      json['TxnGraphData'].forEach((v) {
        txnGraphData!.add(TxnGraphDataModel.fromJson(v));
      });
    }
    if (json['recipientData'] != null) {
      recipientData = <ChartRecipientDataModel>[];
      json['recipientData'].forEach((v) {
        recipientData!.add(ChartRecipientDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalSendAmount'] = totalSendAmount;
    if (txnGraphData != null) {
      data['TxnGraphData'] = txnGraphData!.map((v) => v.toJson()).toList();
    }
    if (recipientData != null) {
      data['recipientData'] = recipientData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChartRecipientDataModel {
  String? recipientName;
  String? profileImage;
  String? totalSendAmount;

  ChartRecipientDataModel({
    this.recipientName,
    this.profileImage,
    this.totalSendAmount,
  });

  ChartRecipientDataModel.fromJson(Map<String, dynamic> json) {
    recipientName = json['recipient_name'];
    profileImage = json['profileImage'];
    totalSendAmount = json['total_send_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipient_name'] = recipientName;
    data['profileImage'] = profileImage;
    data['total_send_amount'] = totalSendAmount;
    return data;
  }
}

class TxnGraphDataModel {
  String? totalSendAmount;
  String? month;

  TxnGraphDataModel({this.totalSendAmount, this.month});

  TxnGraphDataModel.fromJson(Map<String, dynamic> json) {
    totalSendAmount = json['total_send_amount'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_send_amount'] = totalSendAmount;
    data['month'] = month;
    return data;
  }
}

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
        txnGraphData!.add(new TxnGraphDataModel.fromJson(v));
      });
    }
    if (json['recipientData'] != null) {
      recipientData = <ChartRecipientDataModel>[];
      json['recipientData'].forEach((v) {
        recipientData!.add(new ChartRecipientDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSendAmount'] = this.totalSendAmount;
    if (this.txnGraphData != null) {
      data['TxnGraphData'] = this.txnGraphData!.map((v) => v.toJson()).toList();
    }
    if (this.recipientData != null) {
      data['recipientData'] =
          this.recipientData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChartRecipientDataModel {
  String? recipientName;
  String? profileImage;
  String? totalSendAmount;

  ChartRecipientDataModel({this.recipientName, this.profileImage, this.totalSendAmount});

  ChartRecipientDataModel.fromJson(Map<String, dynamic> json) {
    recipientName = json['recipient_name'];
    profileImage = json['profileImage'];
    totalSendAmount = json['total_send_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient_name'] = this.recipientName;
    data['profileImage'] = this.profileImage;
    data['total_send_amount'] = this.totalSendAmount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_send_amount'] = this.totalSendAmount;
    data['month'] = this.month;
    return data;
  }
}

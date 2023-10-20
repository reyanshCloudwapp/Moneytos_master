class ScheduleTransferResponse {
  bool? status;
  String? message;
  Data? data;

  ScheduleTransferResponse({this.status, this.message, this.data});

  ScheduleTransferResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ScheduleTransfer? scheduleTransfer;

  Data({this.scheduleTransfer});

  Data.fromJson(Map<String, dynamic> json) {
    scheduleTransfer = json['ScheduleTransfer'] != null
        ? new ScheduleTransfer.fromJson(json['ScheduleTransfer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.scheduleTransfer != null) {
      data['ScheduleTransfer'] = this.scheduleTransfer!.toJson();
    }
    return data;
  }
}

class ScheduleTransfer {
  int? currentPage;
  List<ScheduleData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ScheduleTransfer(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ScheduleTransfer.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ScheduleData>[];
      json['data'].forEach((v) {
        data!.add(new ScheduleData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ScheduleData {
  int? id;
  String? scheduleDate;
  String? scheduleExpDate;
  String? scheduleType;
  String? userId;
  String? recipientServerId;
  String? recipientId;
  String? recipientName;
  String? recipientImage;
  String? sendAmount;
  String? recipientRecivedAmount;
  String? transactionFees;
  String? monyetosfee;
  String? exchangeRate;
  String? recipientReceiveMethod;
  String? deliveryMethodType;
  String? recipientReceiveMethodLast4digit;
  String? senderSendMethod;
  String? senderSendMethodId;
  String? senderSendMethodLast4digit;
  String? trasnsferReason;
  String? trasnsferReasonId;
  String? sendingCurrency;
  String? receivingCurrency;
  String? dstCountryIso3Code;
  String? recipientAccountId;
  String? scheduleStatus;
  String? createdAt;
  String? updatedAt;
  String? paymentDone;

  ScheduleData(
      {this.id,
        this.scheduleDate,
        this.scheduleExpDate,
        this.scheduleType,
        this.userId,
        this.recipientServerId,
        this.recipientId,
        this.recipientName,
        this.recipientImage,
        this.sendAmount,
        this.recipientRecivedAmount,
        this.transactionFees,
        this.monyetosfee,
        this.exchangeRate,
        this.recipientReceiveMethod,
        this.deliveryMethodType,
        this.recipientReceiveMethodLast4digit,
        this.senderSendMethod,
        this.senderSendMethodId,
        this.senderSendMethodLast4digit,
        this.trasnsferReason,
        this.trasnsferReasonId,
        this.sendingCurrency,
        this.receivingCurrency,
        this.dstCountryIso3Code,
        this.recipientAccountId,
        this.scheduleStatus,
        this.createdAt,
        this.updatedAt,
        this.paymentDone});

  ScheduleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleDate = json['schedule_date'];
    scheduleExpDate = json['schedule_exp_date'];
    scheduleType = json['schedule_type'];
    userId = json['user_id'];
    recipientServerId = json['recipient_server_id'];
    recipientId = json['recipientId'];
    recipientName = json['recipient_name'];
    recipientImage = json['recipient_image'];
    sendAmount = json['send_amount'];
    recipientRecivedAmount = json['recipient_recived_amount'];
    transactionFees = json['transaction_fees'];
    monyetosfee = json['monyetosfee'];
    exchangeRate = json['exchange_rate'];
    recipientReceiveMethod = json['recipient_receive_method'];
    deliveryMethodType = json['delivery_method_type'];
    recipientReceiveMethodLast4digit =
    json['recipient_receive_method_last4digit'];
    senderSendMethod = json['sender_send_method'];
    senderSendMethodId = json['sender_send_method_id'];
    senderSendMethodLast4digit = json['sender_send_method_last4digit'];
    trasnsferReason = json['trasnsfer_reason'];
    trasnsferReasonId = json['trasnsfer_reason_id'];
    sendingCurrency = json['sending_currency'];
    receivingCurrency = json['receiving_currency'];
    dstCountryIso3Code = json['dstCountryIso3Code'];
    recipientAccountId = json['recipientAccountId'];
    scheduleStatus = json['schedule_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentDone = json['payment_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['schedule_date'] = this.scheduleDate;
    data['schedule_exp_date'] = this.scheduleExpDate;
    data['schedule_type'] = this.scheduleType;
    data['user_id'] = this.userId;
    data['recipient_server_id'] = this.recipientServerId;
    data['recipientId'] = this.recipientId;
    data['recipient_name'] = this.recipientName;
    data['recipient_image'] = this.recipientImage;
    data['send_amount'] = this.sendAmount;
    data['recipient_recived_amount'] = this.recipientRecivedAmount;
    data['transaction_fees'] = this.transactionFees;
    data['monyetosfee'] = this.monyetosfee;
    data['exchange_rate'] = this.exchangeRate;
    data['recipient_receive_method'] = this.recipientReceiveMethod;
    data['delivery_method_type'] = this.deliveryMethodType;
    data['recipient_receive_method_last4digit'] =
        this.recipientReceiveMethodLast4digit;
    data['sender_send_method'] = this.senderSendMethod;
    data['sender_send_method_id'] = this.senderSendMethodId;
    data['sender_send_method_last4digit'] = this.senderSendMethodLast4digit;
    data['trasnsfer_reason'] = this.trasnsferReason;
    data['trasnsfer_reason_id'] = this.trasnsferReasonId;
    data['sending_currency'] = this.sendingCurrency;
    data['receiving_currency'] = this.receivingCurrency;
    data['dstCountryIso3Code'] = this.dstCountryIso3Code;
    data['recipientAccountId'] = this.recipientAccountId;
    data['schedule_status'] = this.scheduleStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_done'] = this.paymentDone;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class ScheduleTransferResponse {
  bool? status;
  String? message;
  Data? data;

  ScheduleTransferResponse({this.status, this.message, this.data});

  ScheduleTransferResponse.fromJson(Map<String, dynamic> json) {
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
  ScheduleTransfer? scheduleTransfer;

  Data({this.scheduleTransfer});

  Data.fromJson(Map<String, dynamic> json) {
    scheduleTransfer = json['ScheduleTransfer'] != null
        ? ScheduleTransfer.fromJson(json['ScheduleTransfer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (scheduleTransfer != null) {
      data['ScheduleTransfer'] = scheduleTransfer!.toJson();
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

  ScheduleTransfer({
    this.currentPage,
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
    this.total,
  });

  ScheduleTransfer.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ScheduleData>[];
      json['data'].forEach((v) {
        data!.add(ScheduleData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
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

  ScheduleData({
    this.id,
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
    this.paymentDone,
  });

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
    data['id'] = id;
    data['schedule_date'] = scheduleDate;
    data['schedule_exp_date'] = scheduleExpDate;
    data['schedule_type'] = scheduleType;
    data['user_id'] = userId;
    data['recipient_server_id'] = recipientServerId;
    data['recipientId'] = recipientId;
    data['recipient_name'] = recipientName;
    data['recipient_image'] = recipientImage;
    data['send_amount'] = sendAmount;
    data['recipient_recived_amount'] = recipientRecivedAmount;
    data['transaction_fees'] = transactionFees;
    data['monyetosfee'] = monyetosfee;
    data['exchange_rate'] = exchangeRate;
    data['recipient_receive_method'] = recipientReceiveMethod;
    data['delivery_method_type'] = deliveryMethodType;
    data['recipient_receive_method_last4digit'] =
        recipientReceiveMethodLast4digit;
    data['sender_send_method'] = senderSendMethod;
    data['sender_send_method_id'] = senderSendMethodId;
    data['sender_send_method_last4digit'] = senderSendMethodLast4digit;
    data['trasnsfer_reason'] = trasnsferReason;
    data['trasnsfer_reason_id'] = trasnsferReasonId;
    data['sending_currency'] = sendingCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['dstCountryIso3Code'] = dstCountryIso3Code;
    data['recipientAccountId'] = recipientAccountId;
    data['schedule_status'] = scheduleStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['payment_done'] = paymentDone;
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
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

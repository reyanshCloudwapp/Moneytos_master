class LatestTransferResponse {
  bool? status;
  String? message;
  LatestTransferData? data;

  LatestTransferResponse({this.status, this.message, this.data});

  LatestTransferResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? LatestTransferData.fromJson(json['data']) : null;
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

class LatestTransferData {
  // int? totalSendAmount;
  TxnData? txnData;

  LatestTransferData({this.txnData});

  LatestTransferData.fromJson(Map<String, dynamic> json) {
    // json['totalSendAmount'] = new TxnData.fromJson(json['totalSendAmount']);
    txnData =
        json['TxnData'] != null ? TxnData.fromJson(json['TxnData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['totalSendAmount'] = this.totalSendAmount;
    if (txnData != null) {
      data['TxnData'] = txnData!.toJson();
    }
    return data;
  }
}

class TxnData {
  int? currentPage;
  List<TxnSubData>? data;
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

  TxnData({
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

  TxnData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TxnSubData>[];
      json['data'].forEach((v) {
        data!.add(TxnSubData.fromJson(v));
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

class TxnSubData {
  int? id;
  String? readyremitTransferId;
  String? confirmationNumber;
  String? userId;
  String? sendAmount;
  String? recipientId;
  String? recipientAccountId;
  String? recipientImage;
  String? recipientName;
  String? readyremitStatus;
  String? niumupdatestatusdescription;
  String? magicpayTxnid;
  String? magicpayTxnstatus;
  String? deliveryMethodType;
  String? recipientRecivedAmout;
  String? transactionFees;
  String? monyetosfee;
  String? exchangeRate;
  String? recipientReceiveMethod;
  String? recipientReceiveMethodLast4digit;
  String? senderSendMethod;
  String? senderSendMethodId;
  String? senderSendMethodLast4digit;
  String? trasnsferReason;
  String? trasnsferReasonId;
  String? sendingCurrency;
  String? receivingCurrency;
  String? txnType;
  String? scheduleId;
  String? realtimeIp;
  String? realtimeAddress;
  String? magicpayeventType;
  String? magicpayeventSource;
  String? partnerPaymentMethod;
  String? createdAt;
  String? updatedAt;
  String? profileImage;
  String? countryIso3Code;
  String? countryIso2Code;
  String? countryName;
  String? phonecode;
  String? phoneNumber;
  String? countryEmoji;
  String? newCreatedAt;
  String? readyremitStatus5;

  TxnSubData({
    this.id,
    this.readyremitTransferId,
    this.confirmationNumber,
    this.userId,
    this.sendAmount,
    this.recipientId,
    this.recipientAccountId,
    this.recipientImage,
    this.recipientName,
    this.readyremitStatus,
    this.niumupdatestatusdescription,
    this.magicpayTxnid,
    this.magicpayTxnstatus,
    this.deliveryMethodType,
    this.recipientRecivedAmout,
    this.transactionFees,
    this.monyetosfee,
    this.exchangeRate,
    this.recipientReceiveMethod,
    this.recipientReceiveMethodLast4digit,
    this.senderSendMethod,
    this.senderSendMethodId,
    this.senderSendMethodLast4digit,
    this.trasnsferReason,
    this.trasnsferReasonId,
    this.sendingCurrency,
    this.receivingCurrency,
    this.txnType,
    this.scheduleId,
    this.realtimeIp,
    this.realtimeAddress,
    this.magicpayeventType,
    this.magicpayeventSource,
    this.partnerPaymentMethod,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.countryIso3Code,
    this.countryIso2Code,
    this.countryName,
    this.phonecode,
    this.phoneNumber,
    this.countryEmoji,
    this.newCreatedAt,
    this.readyremitStatus5,
  });

  TxnSubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readyremitTransferId = json['readyremit_transferId'];
    confirmationNumber = json['confirmationNumber'];
    userId = json['user_id'];
    sendAmount = json['send_amount'];
    recipientId = json['recipientId'];
    recipientAccountId = json['recipientAccountId'];
    recipientImage = json['recipient_image'];
    recipientName = json['recipient_name'];
    readyremitStatus = json['readyremit_status'];
    niumupdatestatusdescription = json['niumupdatestatusdescription'];
    magicpayTxnid = json['magicpay_txnid'];
    magicpayTxnstatus = json['magicpay_txnstatus'];
    deliveryMethodType = json['delivery_method_type'];
    recipientRecivedAmout = json['recipient_recived_amout'];
    transactionFees = json['transaction_fees'];
    monyetosfee = json['monyetosfee'].toString();
    exchangeRate = json['exchange_rate'];
    recipientReceiveMethod = json['recipient_receive_method'];
    recipientReceiveMethodLast4digit =
        json['recipient_receive_method_last4digit'];
    senderSendMethod = json['sender_send_method'];
    senderSendMethodId = json['sender_send_method_id'];
    senderSendMethodLast4digit = json['sender_send_method_last4digit'];
    trasnsferReason = json['trasnsfer_reason'];
    trasnsferReasonId = json['trasnsfer_reason_id'];
    sendingCurrency = json['sending_currency'];
    receivingCurrency = json['receiving_currency'];
    txnType = json['txn_type'];
    scheduleId = json['schedule_id'];
    realtimeIp = json['realtime_ip'];
    realtimeAddress = json['realtime_address'];
    magicpayeventType = json['magicpayevent_type'];
    magicpayeventSource = json['magicpayevent_source'];
    partnerPaymentMethod = json['partner_payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profileImage'];
    countryIso3Code = json['countryIso3Code'];
    countryIso2Code = json['countryIso2Code'];
    countryName = json['country_name'];
    phonecode = json['phonecode'];
    phoneNumber = json['phone_number'];
    countryEmoji = json['country_emoji'];
    newCreatedAt = json['new_created_at'];
    readyremitStatus5 = json['readyremit_status5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readyremit_transferId'] = readyremitTransferId;
    data['confirmationNumber'] = confirmationNumber;
    data['user_id'] = userId;
    data['send_amount'] = sendAmount;
    data['recipientId'] = recipientId;
    data['recipientAccountId'] = recipientAccountId;
    data['recipient_image'] = recipientImage;
    data['recipient_name'] = recipientName;
    data['readyremit_status'] = readyremitStatus;
    data['niumupdatestatusdescription'] = niumupdatestatusdescription;
    data['magicpay_txnid'] = magicpayTxnid;
    data['magicpay_txnstatus'] = magicpayTxnstatus;
    data['delivery_method_type'] = deliveryMethodType;
    data['recipient_recived_amout'] = recipientRecivedAmout;
    data['transaction_fees'] = transactionFees;
    data['monyetosfee'] = monyetosfee;
    data['exchange_rate'] = exchangeRate;
    data['recipient_receive_method'] = recipientReceiveMethod;
    data['recipient_receive_method_last4digit'] =
        recipientReceiveMethodLast4digit;
    data['sender_send_method'] = senderSendMethod;
    data['sender_send_method_id'] = senderSendMethodId;
    data['sender_send_method_last4digit'] = senderSendMethodLast4digit;
    data['trasnsfer_reason'] = trasnsferReason;
    data['trasnsfer_reason_id'] = trasnsferReasonId;
    data['sending_currency'] = sendingCurrency;
    data['receiving_currency'] = receivingCurrency;
    data['txn_type'] = txnType;
    data['schedule_id'] = scheduleId;
    data['realtime_ip'] = realtimeIp;
    data['realtime_address'] = realtimeAddress;
    data['magicpayevent_type'] = magicpayeventType;
    data['magicpayevent_source'] = magicpayeventSource;
    data['partner_payment_method'] = partnerPaymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profileImage'] = profileImage;
    data['countryIso3Code'] = countryIso3Code;
    data['countryIso2Code'] = countryIso2Code;
    data['country_name'] = countryName;
    data['phonecode'] = phonecode;
    data['phone_number'] = phoneNumber;
    data['country_emoji'] = countryEmoji;
    data['new_created_at'] = newCreatedAt;
    data['readyremit_status5'] = readyremitStatus5;
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

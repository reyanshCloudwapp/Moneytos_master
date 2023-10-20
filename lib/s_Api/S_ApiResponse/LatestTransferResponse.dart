class LatestTransferResponse {
  bool? status;
  String? message;
  LatestTransferData? data;

  LatestTransferResponse({this.status, this.message, this.data});

  LatestTransferResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LatestTransferData.fromJson(json['data']) : null;
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

class LatestTransferData {
  // int? totalSendAmount;
  TxnData? txnData;

  LatestTransferData({this.txnData});

  LatestTransferData.fromJson(Map<String, dynamic> json) {
    // json['totalSendAmount'] = new TxnData.fromJson(json['totalSendAmount']);
    txnData =
    json['TxnData'] != null ? new TxnData.fromJson(json['TxnData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['totalSendAmount'] = this.totalSendAmount;
    if (this.txnData != null) {
      data['TxnData'] = this.txnData!.toJson();
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

  TxnData(
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

  TxnData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TxnSubData>[];
      json['data'].forEach((v) {
        data!.add(new TxnSubData.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  TxnSubData(
      {this.id,
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
        this.readyremitStatus5});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readyremit_transferId'] = this.readyremitTransferId;
    data['confirmationNumber'] = this.confirmationNumber;
    data['user_id'] = this.userId;
    data['send_amount'] = this.sendAmount;
    data['recipientId'] = this.recipientId;
    data['recipientAccountId'] = this.recipientAccountId;
    data['recipient_image'] = this.recipientImage;
    data['recipient_name'] = this.recipientName;
    data['readyremit_status'] = this.readyremitStatus;
    data['niumupdatestatusdescription'] = this.niumupdatestatusdescription;
    data['magicpay_txnid'] = this.magicpayTxnid;
    data['magicpay_txnstatus'] = this.magicpayTxnstatus;
    data['delivery_method_type'] = this.deliveryMethodType;
    data['recipient_recived_amout'] = this.recipientRecivedAmout;
    data['transaction_fees'] = this.transactionFees;
    data['monyetosfee'] = this.monyetosfee;
    data['exchange_rate'] = this.exchangeRate;
    data['recipient_receive_method'] = this.recipientReceiveMethod;
    data['recipient_receive_method_last4digit'] =
        this.recipientReceiveMethodLast4digit;
    data['sender_send_method'] = this.senderSendMethod;
    data['sender_send_method_id'] = this.senderSendMethodId;
    data['sender_send_method_last4digit'] = this.senderSendMethodLast4digit;
    data['trasnsfer_reason'] = this.trasnsferReason;
    data['trasnsfer_reason_id'] = this.trasnsferReasonId;
    data['sending_currency'] = this.sendingCurrency;
    data['receiving_currency'] = this.receivingCurrency;
    data['txn_type'] = this.txnType;
    data['schedule_id'] = this.scheduleId;
    data['realtime_ip'] = this.realtimeIp;
    data['realtime_address'] = this.realtimeAddress;
    data['magicpayevent_type'] = this.magicpayeventType;
    data['magicpayevent_source'] = this.magicpayeventSource;
    data['partner_payment_method'] = this.partnerPaymentMethod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profileImage'] = this.profileImage;
    data['countryIso3Code'] = this.countryIso3Code;
    data['countryIso2Code'] = this.countryIso2Code;
    data['country_name'] = this.countryName;
    data['phonecode'] = this.phonecode;
    data['phone_number'] = this.phoneNumber;
    data['country_emoji'] = this.countryEmoji;
    data['new_created_at'] = this.newCreatedAt;
    data['readyremit_status5'] = this.readyremitStatus5;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

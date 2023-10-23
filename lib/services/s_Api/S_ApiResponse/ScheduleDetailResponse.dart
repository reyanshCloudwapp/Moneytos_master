class ScheduleDetailResponse {
  bool? status;
  String? message;
  Data? data;

  ScheduleDetailResponse({this.status, this.message, this.data});

  ScheduleDetailResponse.fromJson(Map<String, dynamic> json) {
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
  Scheduledata? scheduledata;

  Data({this.scheduledata});

  Data.fromJson(Map<String, dynamic> json) {
    scheduledata = json['scheduledata'] != null
        ? Scheduledata.fromJson(json['scheduledata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (scheduledata != null) {
      data['scheduledata'] = scheduledata!.toJson();
    }
    return data;
  }
}

class Scheduledata {
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
  int? isCancelled;
  String? createdAt;
  String? updatedAt;
  String? recipientPhoneNumber;
  String? recipientPhonecode;
  String? paymentDone;
  List<String>? scheduleDatesOnpaymentdone;

  Scheduledata({
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
    this.isCancelled,
    this.createdAt,
    this.updatedAt,
    this.recipientPhoneNumber,
    this.recipientPhonecode,
    this.paymentDone,
    this.scheduleDatesOnpaymentdone,
  });

  Scheduledata.fromJson(Map<String, dynamic> json) {
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
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recipientPhoneNumber = json['recipient_phone_number'];
    recipientPhonecode = json['recipient_phonecode'];
    paymentDone = json['payment_done'];
    scheduleDatesOnpaymentdone =
        json['schedule_dates_onpaymentdone'].cast<String>();
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
    data['schedule_status'] = scheduleStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['recipient_phone_number'] = recipientPhoneNumber;
    data['recipient_phonecode'] = recipientPhonecode;
    data['payment_done'] = paymentDone;
    data['schedule_dates_onpaymentdone'] = scheduleDatesOnpaymentdone;
    return data;
  }
}

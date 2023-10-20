class ScheduleDetailResponse {
  bool? status;
  String? message;
  Data? data;

  ScheduleDetailResponse({this.status, this.message, this.data});

  ScheduleDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Scheduledata? scheduledata;

  Data({this.scheduledata});

  Data.fromJson(Map<String, dynamic> json) {
    scheduledata = json['scheduledata'] != null
        ? new Scheduledata.fromJson(json['scheduledata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.scheduledata != null) {
      data['scheduledata'] = this.scheduledata!.toJson();
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

  Scheduledata(
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
        this.isCancelled,
        this.createdAt,
        this.updatedAt,
        this.recipientPhoneNumber,
        this.recipientPhonecode,
        this.paymentDone,
        this.scheduleDatesOnpaymentdone});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['schedule_status'] = this.scheduleStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['recipient_phone_number'] = this.recipientPhoneNumber;
    data['recipient_phonecode'] = this.recipientPhonecode;
    data['payment_done'] = this.paymentDone;
    data['schedule_dates_onpaymentdone'] = this.scheduleDatesOnpaymentdone;
    return data;
  }
}

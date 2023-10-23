class TxnDetailResponse {
  bool? status;
  String? message;
  Data? data;

  TxnDetailResponse({this.status, this.message, this.data});

  TxnDetailResponse.fromJson(Map<String, dynamic> json) {
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
  String? recipientPhonecode;
  String? recipientPhoneNumber;
  RecipientBankData? recipientBankData;
  String? readyremitStatus5;
  String? newCreatedAt;

  Data({
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
    this.recipientPhonecode,
    this.recipientPhoneNumber,
    this.recipientBankData,
    this.readyremitStatus5,
    this.newCreatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    recipientPhonecode = json['recipient_phonecode'];
    recipientPhoneNumber = json['recipient_phone_number'];
    recipientBankData = json['recipientBankData'] != null
        ? RecipientBankData.fromJson(json['recipientBankData'])
        : null;
    readyremitStatus5 = json['readyremit_status5'];
    newCreatedAt = json['new_created_at'];
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
    data['recipient_phonecode'] = recipientPhonecode;
    data['recipient_phone_number'] = recipientPhoneNumber;
    if (recipientBankData != null) {
      data['recipientBankData'] = recipientBankData!.toJson();
    }
    data['readyremit_status5'] = readyremitStatus5;
    data['new_created_at'] = newCreatedAt;
    return data;
  }
}

class RecipientBankData {
  int? id;
  String? rid;
  String? uid;
  String? routingCodeType1;
  String? routingCodeValue1;
  String? routingCodeType2;
  String? routingCodeValue2;
  String? accountNumber;
  String? bankAccountType;
  String? bankName;
  String? bankCode;
  String? mfsBankCode;
  String? deliveryMethodType;
  String? mobileOperator;
  String? partnerPaymentMethod;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  RecipientBankData({
    this.id,
    this.rid,
    this.uid,
    this.routingCodeType1,
    this.routingCodeValue1,
    this.routingCodeType2,
    this.routingCodeValue2,
    this.accountNumber,
    this.bankAccountType,
    this.bankName,
    this.bankCode,
    this.mfsBankCode,
    this.deliveryMethodType,
    this.mobileOperator,
    this.partnerPaymentMethod,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  RecipientBankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rid = json['rid'];
    uid = json['uid'];
    routingCodeType1 = json['routing_code_type_1'];
    routingCodeValue1 = json['routing_code_value_1'];
    routingCodeType2 = json['routing_code_type_2'];
    routingCodeValue2 = json['routing_code_value_2'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    mfsBankCode = json['mfs_bank_code'];
    deliveryMethodType = json['delivery_method_type'];
    mobileOperator = json['mobile_operator'];
    partnerPaymentMethod = json['partner_payment_method'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rid'] = rid;
    data['uid'] = uid;
    data['routing_code_type_1'] = routingCodeType1;
    data['routing_code_value_1'] = routingCodeValue1;
    data['routing_code_type_2'] = routingCodeType2;
    data['routing_code_value_2'] = routingCodeValue2;
    data['account_number'] = accountNumber;
    data['bank_account_type'] = bankAccountType;
    data['bank_name'] = bankName;
    data['bank_code'] = bankCode;
    data['mfs_bank_code'] = mfsBankCode;
    data['delivery_method_type'] = deliveryMethodType;
    data['mobile_operator'] = mobileOperator;
    data['partner_payment_method'] = partnerPaymentMethod;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

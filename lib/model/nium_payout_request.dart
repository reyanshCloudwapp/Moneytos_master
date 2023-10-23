class NiumPayoutsRequest {
  String? requestId;
  String? transactionNumber;
  double? destinationAccount;
  String? destinationCurrency;
  String? localConversionCurrency;
  String? statementNarrative;
  String? originalRemitterFi;
  int? sourceAccount;
  String? feePayer;
  Beneficiary? beneficiary;
  Remitter? remitter;

  AdditionalInfo? additionalInfo;
  String? routingCodeType1;
  String? routingCodeValue1;
  String? routingCodeType2;
  String? routingCodeValue2;
  String? routingCodeType3;
  String? routingCodeValue3;
  String? payoutMethod;
  String? swiftFeePayer;
  String? documentReference;

  NiumPayoutsRequest({
    this.requestId,
    this.transactionNumber,
    this.destinationAccount,
    this.destinationCurrency,
    this.localConversionCurrency,
    this.statementNarrative,
    this.originalRemitterFi,
    this.sourceAccount,
    this.feePayer,
    this.beneficiary,
    this.remitter,
    this.additionalInfo,
    this.routingCodeType1,
    this.routingCodeValue1,
    this.routingCodeType2,
    this.routingCodeValue2,
    this.routingCodeType3,
    this.routingCodeValue3,
    this.payoutMethod,
    this.swiftFeePayer,
    this.documentReference,
  });

  NiumPayoutsRequest.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    transactionNumber = json['transaction_number'];
    destinationAccount = json['destination_amount'];
    destinationCurrency = json['destination_currency'];
    localConversionCurrency = json['local_conversion_currency'];
    statementNarrative = json['statement_narrative'];
    originalRemitterFi = json['original_remitter_fi'];
    sourceAccount = json['source_account'];
    feePayer = json['fee_payer'];
    beneficiary = json['beneficiary'] != null
        ? Beneficiary.fromJson(json['beneficiary'])
        : null;
    remitter =
        json['remitter'] != null ? Remitter.fromJson(json['remitter']) : null;
    additionalInfo = json['additional_info'] != null
        ? AdditionalInfo.fromJson(json['additional_info'])
        : null;
    routingCodeType1 = json['routing_code_type_1'];
    routingCodeValue1 = json['routing_code_value_1'];
    routingCodeType2 = json['routing_code_type_2'];
    routingCodeValue2 = json['routing_code_value_2'];
    routingCodeType3 = json['routing_code_type_3'];
    routingCodeValue3 = json['routing_code_value_3'];
    payoutMethod = json['payout_method'];
    swiftFeePayer = json['swift_fee_payer'];
    documentReference = json['document_reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['transaction_number'] = transactionNumber;
    data['destination_amount'] = destinationAccount;
    data['destination_currency'] = destinationCurrency;
    data['local_conversion_currency'] = localConversionCurrency;
    data['statement_narrative'] = statementNarrative;
    data['original_remitter_fi'] = originalRemitterFi;
    data['source_account'] = sourceAccount;
    data['fee_payer'] = feePayer;
    if (beneficiary != null) {
      data['beneficiary'] = beneficiary!.toJson();
    }
    if (remitter != null) {
      data['remitter'] = remitter!.toJson();
    }
    if (additionalInfo != null) {
      data['additional_info'] = additionalInfo!.toJson();
    }
    data['routing_code_type_1'] = routingCodeType1;
    data['routing_code_value_1'] = routingCodeValue1;
    data['routing_code_type_2'] = routingCodeType2;
    data['routing_code_value_2'] = routingCodeValue2;
    data['routing_code_type_3'] = routingCodeType3;
    data['routing_code_value_3'] = routingCodeValue3;
    data['payout_method'] = payoutMethod;
    data['swift_fee_payer'] = swiftFeePayer;
    data['document_reference'] = documentReference;
    return data;
  }
}

class Beneficiary {
  String? name;
  String? address;
  String? city;
  String? countryCode;
  String? email;
  String? accountType;
  String? contactNumber;
  String? state;
  String? postcode;
  String? accountNumber;
  String? bankAccountType;
  String? bankName;
  String? bankCode;
  String? relationship;
  String? accountIdentifierType;
  String? accountIdentifierValue;
  String? contactCountryCode;
  String? nameLocalLanguage;

  Beneficiary({
    this.name,
    this.address,
    this.city,
    this.countryCode,
    this.email,
    this.accountType,
    this.contactNumber,
    this.state,
    this.postcode,
    this.accountNumber,
    this.bankAccountType,
    this.bankName,
    this.bankCode,
    this.relationship,
    this.accountIdentifierType,
    this.accountIdentifierValue,
    this.contactCountryCode,
    this.nameLocalLanguage,
  });

  Beneficiary.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    city = json['city'];
    countryCode = json['country_code'];
    email = json['email'];
    accountType = json['account_type'];
    contactNumber = json['contact_number'];
    state = json['state'];
    postcode = json['postcode'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    relationship = json['relationship'];
    accountIdentifierType = json['account_identifier_type'];
    accountIdentifierValue = json['account_identifier_value'];
    contactCountryCode = json['contact_country_code'];
    nameLocalLanguage = json['name_local_language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['account_type'] = accountType;
    data['contact_number'] = contactNumber;
    data['state'] = state;
    data['postcode'] = postcode;
    data['account_number'] = accountNumber;
    data['bank_account_type'] = bankAccountType;
    data['bank_name'] = bankName;
    data['bank_code'] = bankCode;
    data['relationship'] = relationship;
    data['account_identifier_type'] = accountIdentifierType;
    data['account_identifier_value'] = accountIdentifierValue;
    data['contact_country_code'] = contactCountryCode;
    data['name_local_language'] = nameLocalLanguage;
    return data;
  }
}

class Remitter {
  String? name;
  bool? givenName;
  String? accountType;
  String? bankAccountNumber;
  String? identificationType;
  String? identificationNumber;
  String? countryCode;
  String? address;
  String? purposeCode;
  String? sourceOfIncome;
  String? contactNumber;
  String? dob;
  String? city;
  String? postcode;
  String? state;
  String? sourceOfFunds;
  String? placeOfBirth;
  String? nationality;
  String? occupation;

  Remitter({
    this.name,
    this.givenName,
    this.accountType,
    this.bankAccountNumber,
    this.identificationType,
    this.identificationNumber,
    this.countryCode,
    this.address,
    this.purposeCode,
    this.sourceOfIncome,
    this.contactNumber,
    this.dob,
    this.city,
    this.postcode,
    this.state,
    this.sourceOfFunds,
    this.placeOfBirth,
    this.nationality,
    this.occupation,
  });

  Remitter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    givenName = json['given_name'];
    accountType = json['account_type'];
    bankAccountNumber = json['bank_account_number'];
    identificationType = json['identification_type'];
    identificationNumber = json['identification_number'];
    countryCode = json['country_code'];
    address = json['address'];
    purposeCode = json['purpose_code'];
    sourceOfIncome = json['source_of_income'];
    contactNumber = json['contact_number'];
    dob = json['dob'];
    city = json['city'];
    postcode = json['postcode'];
    state = json['state'];
    sourceOfFunds = json['source_of_funds'];
    placeOfBirth = json['place_of_birth'];
    nationality = json['nationality'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['given_name'] = givenName;
    data['account_type'] = accountType;
    data['bank_account_number'] = bankAccountNumber;
    data['identification_type'] = identificationType;
    data['identification_number'] = identificationNumber;
    data['country_code'] = countryCode;
    data['address'] = address;
    data['purpose_code'] = purposeCode;
    data['source_of_income'] = sourceOfIncome;
    data['contact_number'] = contactNumber;
    data['dob'] = dob;
    data['city'] = city;
    data['postcode'] = postcode;
    data['state'] = state;
    data['source_of_funds'] = sourceOfFunds;
    data['place_of_birth'] = placeOfBirth;
    data['nationality'] = nationality;
    data['occupation'] = occupation;
    return data;
  }
}

class AdditionalInfo {
  String? tradeOrderId;
  String? tradeTime;
  String? tradeCurrency;
  String? tradeAmount;
  String? tradeName;
  String? tradeCount;
  String? goodsCarrier;
  String? serviceDetail;
  String? serviceTime;
  String? cashPickup;
  String? tradePlatformName;

  AdditionalInfo({
    this.tradeOrderId,
    this.tradeTime,
    this.tradeCurrency,
    this.tradeAmount,
    this.tradeName,
    this.tradeCount,
    this.goodsCarrier,
    this.serviceDetail,
    this.serviceTime,
    this.cashPickup,
    this.tradePlatformName,
  });

  AdditionalInfo.fromJson(Map<String, dynamic> json) {
    tradeOrderId = json['trade_order_id'];
    tradeTime = json['trade_time'];
    tradeCurrency = json['trade_currency'];
    tradeAmount = json['trade_amount'];
    tradeName = json['trade_name'];
    tradeCount = json['trade_count'];
    goodsCarrier = json['goods_carrier'];
    serviceDetail = json['service_detail'];
    serviceTime = json['service_time'];
    cashPickup = json['cash_pickup'];
    tradePlatformName = json['trade_platform_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trade_order_id'] = tradeOrderId;
    data['trade_time'] = tradeTime;
    data['trade_currency'] = tradeCurrency;
    data['trade_amount'] = tradeAmount;
    data['trade_name'] = tradeName;
    data['trade_count'] = tradeCount;
    data['goods_carrier'] = goodsCarrier;
    data['service_detail'] = serviceDetail;
    data['service_time'] = serviceTime;
    data['cash_pickup'] = cashPickup;
    data['trade_platform_name'] = tradePlatformName;
    return data;
  }
}

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

  NiumPayoutsRequest(
      {this.requestId,
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
        this.documentReference});

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
        ? new Beneficiary.fromJson(json['beneficiary'])
        : null;
    remitter = json['remitter'] != null
        ? new Remitter.fromJson(json['remitter'])
        : null;
    additionalInfo = json['additional_info'] != null
        ? new AdditionalInfo.fromJson(json['additional_info'])
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['transaction_number'] = this.transactionNumber;
    data['destination_amount'] = this.destinationAccount;
    data['destination_currency'] = this.destinationCurrency;
    data['local_conversion_currency'] = this.localConversionCurrency;
    data['statement_narrative'] = this.statementNarrative;
    data['original_remitter_fi'] = this.originalRemitterFi;
    data['source_account'] = this.sourceAccount;
    data['fee_payer'] = this.feePayer;
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary!.toJson();
    }
    if (this.remitter != null) {
      data['remitter'] = this.remitter!.toJson();
    }
    if (this.additionalInfo != null) {
      data['additional_info'] = this.additionalInfo!.toJson();
    }
    data['routing_code_type_1'] = this.routingCodeType1;
    data['routing_code_value_1'] = this.routingCodeValue1;
    data['routing_code_type_2'] = this.routingCodeType2;
    data['routing_code_value_2'] = this.routingCodeValue2;
    data['routing_code_type_3'] = this.routingCodeType3;
    data['routing_code_value_3'] = this.routingCodeValue3;
    data['payout_method'] = this.payoutMethod;
    data['swift_fee_payer'] = this.swiftFeePayer;
    data['document_reference'] = this.documentReference;
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

  Beneficiary(
      {this.name,
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
        this.nameLocalLanguage});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['account_type'] = this.accountType;
    data['contact_number'] = this.contactNumber;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['account_number'] = this.accountNumber;
    data['bank_account_type'] = this.bankAccountType;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['relationship'] = this.relationship;
    data['account_identifier_type'] = this.accountIdentifierType;
    data['account_identifier_value'] = this.accountIdentifierValue;
    data['contact_country_code'] = this.contactCountryCode;
    data['name_local_language'] = this.nameLocalLanguage;
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

  Remitter(
      {this.name,
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
        this.occupation});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['given_name'] = this.givenName;
    data['account_type'] = this.accountType;
    data['bank_account_number'] = this.bankAccountNumber;
    data['identification_type'] = this.identificationType;
    data['identification_number'] = this.identificationNumber;
    data['country_code'] = this.countryCode;
    data['address'] = this.address;
    data['purpose_code'] = this.purposeCode;
    data['source_of_income'] = this.sourceOfIncome;
    data['contact_number'] = this.contactNumber;
    data['dob'] = this.dob;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    data['source_of_funds'] = this.sourceOfFunds;
    data['place_of_birth'] = this.placeOfBirth;
    data['nationality'] = this.nationality;
    data['occupation'] = this.occupation;
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

  AdditionalInfo(
      {this.tradeOrderId,
        this.tradeTime,
        this.tradeCurrency,
        this.tradeAmount,
        this.tradeName,
        this.tradeCount,
        this.goodsCarrier,
        this.serviceDetail,
        this.serviceTime,
        this.cashPickup,
        this.tradePlatformName});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trade_order_id'] = this.tradeOrderId;
    data['trade_time'] = this.tradeTime;
    data['trade_currency'] = this.tradeCurrency;
    data['trade_amount'] = this.tradeAmount;
    data['trade_name'] = this.tradeName;
    data['trade_count'] = this.tradeCount;
    data['goods_carrier'] = this.goodsCarrier;
    data['service_detail'] = this.serviceDetail;
    data['service_time'] = this.serviceTime;
    data['cash_pickup'] = this.cashPickup;
    data['trade_platform_name'] = this.tradePlatformName;
    return data;
  }
}

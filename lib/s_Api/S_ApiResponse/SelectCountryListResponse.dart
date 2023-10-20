class SelectCountryListResponse {
  bool? status;
  String? message;
  List<SelectCountryList>? data;

  SelectCountryListResponse({this.status, this.message, this.data});

  SelectCountryListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SelectCountryList>[];
      json['data'].forEach((v) {
        data!.add(new SelectCountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectCountryList {
  int? id;
  String? name;
  String? iso3;
  String? numericCode;
  String? iso2;
  String? phonecode;
  String? capital;
  String? currency;
  String? currencyName;
  String? currencySymbol;
  String? tld;
  String? native;
  String? region;
  String? subregion;
  String? timezones;
  String? translations;
  String? latitude;
  String? longitude;
  String? emoji;
  String? emojiU;
  String? createdAt;
  String? updatedAt;
  String? flag;
  String? wikiDataId;
  String? monyetosfee;
  String? exchangeRate;
  String? phonumberMinMaxValidation;
  int? isShow;
  int? isShowSignup;
  String? markup;
  String? niumExpiryAt;
  String? totalRate;
  int? isTransactionFeesFree;
  int? transactionFeesFreeAmountLimit;
  String? partnerPaymentMethod;
  String? mobileMonyetosfee;
  String? cashMonyetosfee;
  int? mobileIsTransactionFeesFree;
  int? cashIsTransactionFeesFree;
  int? mobileTransactionFeesFreeAmountLimit;
  int? cashTransactionFeesFreeAmountLimit;

  SelectCountryList(
      {this.id,
        this.name,
        this.iso3,
        this.numericCode,
        this.iso2,
        this.phonecode,
        this.capital,
        this.currency,
        this.currencyName,
        this.currencySymbol,
        this.tld,
        this.native,
        this.region,
        this.subregion,
        this.timezones,
        this.translations,
        this.latitude,
        this.longitude,
        this.emoji,
        this.emojiU,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId,
        this.monyetosfee,
        this.exchangeRate,
        this.phonumberMinMaxValidation,
        this.isShow,
        this.isShowSignup,
        this.markup,
        this.niumExpiryAt,
        this.totalRate,
        this.isTransactionFeesFree,
        this.transactionFeesFreeAmountLimit,
        this.partnerPaymentMethod,
        this.mobileMonyetosfee,
        this.cashMonyetosfee,
        this.mobileIsTransactionFeesFree,
        this.cashIsTransactionFeesFree,
        this.mobileTransactionFeesFreeAmountLimit,
        this.cashTransactionFeesFreeAmountLimit});

  SelectCountryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iso3 = json['iso3'];
    numericCode = json['numeric_code'];
    iso2 = json['iso2'];
    phonecode = json['phonecode'];
    capital = json['capital'];
    currency = json['currency'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    tld = json['tld'];
    native = json['native'];
    region = json['region'];
    subregion = json['subregion'];
    timezones = json['timezones'];
    translations = json['translations'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
    wikiDataId = json['wikiDataId'];
    monyetosfee = json['monyetosfee'];
    exchangeRate = json['exchange_rate'].toString();
    phonumberMinMaxValidation = json['phonumber_min_max_validation'];
    isShow = json['is_show'];
    isShowSignup = json['is_show_signup'];
    markup = json['markup'];
    niumExpiryAt = json['nium_expiry_at'];
    totalRate = json['total_rate'].toString();
    isTransactionFeesFree = json['Is_transaction_fees_free'];
    transactionFeesFreeAmountLimit = json['transaction_fees_free_amount_limit'];
    partnerPaymentMethod = json['partner_payment_method'];
    mobileMonyetosfee = json['mobile_monyetosfee'].toString();
    cashMonyetosfee = json['cash_monyetosfee'].toString();
    mobileIsTransactionFeesFree = json['mobile_Is_transaction_fees_free'];
    cashIsTransactionFeesFree = json['cash_Is_transaction_fees_free'];
    mobileTransactionFeesFreeAmountLimit =
    json['mobile_transaction_fees_free_amount_limit'];
    cashTransactionFeesFreeAmountLimit =
    json['cash_transaction_fees_free_amount_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso3'] = this.iso3;
    data['numeric_code'] = this.numericCode;
    data['iso2'] = this.iso2;
    data['phonecode'] = this.phonecode;
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    data['currency_name'] = this.currencyName;
    data['currency_symbol'] = this.currencySymbol;
    data['tld'] = this.tld;
    data['native'] = this.native;
    data['region'] = this.region;
    data['subregion'] = this.subregion;
    data['timezones'] = this.timezones;
    data['translations'] = this.translations;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['emoji'] = this.emoji;
    data['emojiU'] = this.emojiU;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['flag'] = this.flag;
    data['wikiDataId'] = this.wikiDataId;
    data['monyetosfee'] = this.monyetosfee;
    data['exchange_rate'] = this.exchangeRate;
    data['phonumber_min_max_validation'] = this.phonumberMinMaxValidation;
    data['is_show'] = this.isShow;
    data['is_show_signup'] = this.isShowSignup;
    data['markup'] = this.markup;
    data['nium_expiry_at'] = this.niumExpiryAt;
    data['total_rate'] = this.totalRate;
    data['Is_transaction_fees_free'] = this.isTransactionFeesFree;
    data['transaction_fees_free_amount_limit'] =
        this.transactionFeesFreeAmountLimit;
    data['partner_payment_method'] = this.partnerPaymentMethod;
    data['mobile_monyetosfee'] = this.mobileMonyetosfee;
    data['cash_monyetosfee'] = this.cashMonyetosfee;
    data['mobile_Is_transaction_fees_free'] = this.mobileIsTransactionFeesFree;
    data['cash_Is_transaction_fees_free'] = this.cashIsTransactionFeesFree;
    data['mobile_transaction_fees_free_amount_limit'] =
        this.mobileTransactionFeesFreeAmountLimit;
    data['cash_transaction_fees_free_amount_limit'] =
        this.cashTransactionFeesFreeAmountLimit;
    return data;
  }
}

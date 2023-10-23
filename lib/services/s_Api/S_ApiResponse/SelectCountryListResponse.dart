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
        data!.add(SelectCountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
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

  SelectCountryList({
    this.id,
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
    this.cashTransactionFeesFreeAmountLimit,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso3'] = iso3;
    data['numeric_code'] = numericCode;
    data['iso2'] = iso2;
    data['phonecode'] = phonecode;
    data['capital'] = capital;
    data['currency'] = currency;
    data['currency_name'] = currencyName;
    data['currency_symbol'] = currencySymbol;
    data['tld'] = tld;
    data['native'] = native;
    data['region'] = region;
    data['subregion'] = subregion;
    data['timezones'] = timezones;
    data['translations'] = translations;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['flag'] = flag;
    data['wikiDataId'] = wikiDataId;
    data['monyetosfee'] = monyetosfee;
    data['exchange_rate'] = exchangeRate;
    data['phonumber_min_max_validation'] = phonumberMinMaxValidation;
    data['is_show'] = isShow;
    data['is_show_signup'] = isShowSignup;
    data['markup'] = markup;
    data['nium_expiry_at'] = niumExpiryAt;
    data['total_rate'] = totalRate;
    data['Is_transaction_fees_free'] = isTransactionFeesFree;
    data['transaction_fees_free_amount_limit'] = transactionFeesFreeAmountLimit;
    data['partner_payment_method'] = partnerPaymentMethod;
    data['mobile_monyetosfee'] = mobileMonyetosfee;
    data['cash_monyetosfee'] = cashMonyetosfee;
    data['mobile_Is_transaction_fees_free'] = mobileIsTransactionFeesFree;
    data['cash_Is_transaction_fees_free'] = cashIsTransactionFeesFree;
    data['mobile_transaction_fees_free_amount_limit'] =
        mobileTransactionFeesFreeAmountLimit;
    data['cash_transaction_fees_free_amount_limit'] =
        cashTransactionFeesFreeAmountLimit;
    return data;
  }
}

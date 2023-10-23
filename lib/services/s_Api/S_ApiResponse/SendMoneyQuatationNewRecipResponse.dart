class SendMoneyQuatationNewRecipResponse {
  String? destinationCountryISO3Code;
  String? destinationCurrencyISO3Code;
  String? sourceCurrencyIso3Code;
  String? transferMethod;
  SendAmount? sendAmount;
  ReciveAmount? receiveAmount;
  double? rate;
  List<Adjustments>? adjustments;
  TotalCost? totalCost;

  //List<Null>? disclosures;
  DeliverySLA? deliverySLA;

  SendMoneyQuatationNewRecipResponse({
    this.destinationCountryISO3Code,
    this.destinationCurrencyISO3Code,
    this.sourceCurrencyIso3Code,
    this.transferMethod,
    this.sendAmount,
    this.receiveAmount,
    this.rate,
    this.adjustments,
    this.totalCost,
    // this.disclosures,
    this.deliverySLA,
  });

  SendMoneyQuatationNewRecipResponse.fromJson(Map<String, dynamic> json) {
    destinationCountryISO3Code = json['destinationCountryISO3Code'];
    destinationCurrencyISO3Code = json['destinationCurrencyISO3Code'];
    sourceCurrencyIso3Code = json['sourceCurrencyIso3Code'];
    transferMethod = json['transferMethod'];
    sendAmount = json['sendAmount'] != null
        ? SendAmount.fromJson(json['sendAmount'])
        : null;
    receiveAmount = json['receiveAmount'] != null
        ? ReciveAmount.fromJson(json['receiveAmount'])
        : null;
    rate = json['rate'];
    if (json['adjustments'] != null) {
      adjustments = <Adjustments>[];
      json['adjustments'].forEach((v) {
        adjustments!.add(Adjustments.fromJson(v));
      });
    }
    totalCost = json['totalCost'] != null
        ? TotalCost.fromJson(json['totalCost'])
        : null;
    /*  if (json['disclosures'] != null) {
      disclosures = <Null>[];
      json['disclosures'].forEach((v) {
        disclosures!.add(new Null.fromJson(v));
      });
    }*/
    deliverySLA = json['deliverySLA'] != null
        ? DeliverySLA.fromJson(json['deliverySLA'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destinationCountryISO3Code'] = destinationCountryISO3Code;
    data['destinationCurrencyISO3Code'] = destinationCurrencyISO3Code;
    data['sourceCurrencyIso3Code'] = sourceCurrencyIso3Code;
    data['transferMethod'] = transferMethod;
    if (sendAmount != null) {
      data['sendAmount'] = sendAmount!.toJson();
    }
    if (receiveAmount != null) {
      data['receiveAmount'] = receiveAmount!.toJson();
    }
    data['rate'] = rate;
    if (adjustments != null) {
      data['adjustments'] = adjustments!.map((v) => v.toJson()).toList();
    }
    // if (this.totalCost != null) {
    //   data['totalCost'] = this.totalCost!.toJson();
    // }
    /*  if (this.disclosures != null) {
      data['disclosures'] = this.disclosures!.map((v) => v.toJson()).toList();
    }*/
    if (deliverySLA != null) {
      data['deliverySLA'] = deliverySLA!.toJson();
    }
    return data;
  }
}

class SendAmount {
  int? value;
  Currency? currency;

  SendAmount({this.value, this.currency});

  SendAmount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class ReciveAmount {
  int? value;
  Currency? currency;

  ReciveAmount({this.value, this.currency});

  ReciveAmount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class TotalCost {
  int? value;
  Currency? currency;

  TotalCost({this.value, this.currency});

  TotalCost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class Currency {
  String? name;
  String? iso3Code;
  String? symbol;
  int? decimalPlaces;
  String? roundDirection;

  Currency({
    this.name,
    this.iso3Code,
    this.symbol,
    this.decimalPlaces,
    this.roundDirection,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso3Code = json['iso3Code'];
    symbol = json['symbol'];
    decimalPlaces = json['decimalPlaces'];
    roundDirection = json['roundDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['iso3Code'] = iso3Code;
    data['symbol'] = symbol;
    data['decimalPlaces'] = decimalPlaces;
    data['roundDirection'] = roundDirection;
    return data;
  }
}

class Adjustments {
  String? label;
  SendAmount? amount;

  Adjustments({this.label, this.amount});

  Adjustments.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    amount =
        json['amount'] != null ? SendAmount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    return data;
  }
}

class DeliverySLA {
  String? id;
  String? name;

  DeliverySLA({this.id, this.name});

  DeliverySLA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

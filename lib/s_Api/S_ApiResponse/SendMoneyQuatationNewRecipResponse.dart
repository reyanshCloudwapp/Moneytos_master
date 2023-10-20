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

  SendMoneyQuatationNewRecipResponse(
      {this.destinationCountryISO3Code,
        this.destinationCurrencyISO3Code,
        this.sourceCurrencyIso3Code,
        this.transferMethod,
        this.sendAmount,
        this.receiveAmount,
        this.rate,
        this.adjustments,
         this.totalCost,
       // this.disclosures,
        this.deliverySLA});

  SendMoneyQuatationNewRecipResponse.fromJson(Map<String, dynamic> json) {
    destinationCountryISO3Code = json['destinationCountryISO3Code'];
    destinationCurrencyISO3Code = json['destinationCurrencyISO3Code'];
    sourceCurrencyIso3Code = json['sourceCurrencyIso3Code'];
    transferMethod = json['transferMethod'];
    sendAmount = json['sendAmount'] != null ? new SendAmount.fromJson(json['sendAmount']) : null;
    receiveAmount = json['receiveAmount'] != null ? new ReciveAmount.fromJson(json['receiveAmount']) : null;
    rate = json['rate'];
    if (json['adjustments'] != null) {
      adjustments = <Adjustments>[];
      json['adjustments'].forEach((v) {
        adjustments!.add(new Adjustments.fromJson(v));
      });
    }
     totalCost = json['totalCost'] != null
         ? new TotalCost.fromJson(json['totalCost'])
         : null;
  /*  if (json['disclosures'] != null) {
      disclosures = <Null>[];
      json['disclosures'].forEach((v) {
        disclosures!.add(new Null.fromJson(v));
      });
    }*/
    deliverySLA = json['deliverySLA'] != null
        ? new DeliverySLA.fromJson(json['deliverySLA'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destinationCountryISO3Code'] = this.destinationCountryISO3Code;
    data['destinationCurrencyISO3Code'] = this.destinationCurrencyISO3Code;
    data['sourceCurrencyIso3Code'] = this.sourceCurrencyIso3Code;
    data['transferMethod'] = this.transferMethod;
    if (this.sendAmount != null) {
      data['sendAmount'] = this.sendAmount!.toJson();
    }
    if (this.receiveAmount != null) {
      data['receiveAmount'] = this.receiveAmount!.toJson();
    }
    data['rate'] = this.rate;
    if (this.adjustments != null) {
      data['adjustments'] = this.adjustments!.map((v) => v.toJson()).toList();
    }
    // if (this.totalCost != null) {
    //   data['totalCost'] = this.totalCost!.toJson();
    // }
  /*  if (this.disclosures != null) {
      data['disclosures'] = this.disclosures!.map((v) => v.toJson()).toList();
    }*/
    if (this.deliverySLA != null) {
      data['deliverySLA'] = this.deliverySLA!.toJson();
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
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
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
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
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
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
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

  Currency(
      {this.name,
        this.iso3Code,
        this.symbol,
        this.decimalPlaces,
        this.roundDirection});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso3Code = json['iso3Code'];
    symbol = json['symbol'];
    decimalPlaces = json['decimalPlaces'];
    roundDirection = json['roundDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso3Code'] = this.iso3Code;
    data['symbol'] = this.symbol;
    data['decimalPlaces'] = this.decimalPlaces;
    data['roundDirection'] = this.roundDirection;
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
    json['amount'] != null ? new SendAmount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

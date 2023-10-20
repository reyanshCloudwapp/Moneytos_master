class HomeExchangerateResponse {
  bool? status;
  String? message;
  List<ExchangeRateData>? data;

  HomeExchangerateResponse({this.status, this.message, this.data});

  HomeExchangerateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ExchangeRateData>[];
      json['data'].forEach((v) {
        data!.add(new ExchangeRateData.fromJson(v));
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

class ExchangeRateData {
  String? iso3;
  String? totalRate;
  String? currency;
  int? totalTransactions;

  ExchangeRateData({this.iso3, this.totalRate, this.currency, this.totalTransactions});

  ExchangeRateData.fromJson(Map<String, dynamic> json) {
    iso3 = json['iso3'];
    totalRate = json['total_rate'];
    currency = json['currency'];
    totalTransactions = json['total_transactions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso3'] = this.iso3;
    data['total_rate'] = this.totalRate;
    data['currency'] = this.currency;
    data['total_transactions'] = this.totalTransactions;
    return data;
  }
}

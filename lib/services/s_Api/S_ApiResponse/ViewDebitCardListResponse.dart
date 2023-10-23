class ViewDebitCardListResponse {
  int? id;
  int? customerId;
  String? name;
  String? createdAt;
  String? cardType;
  String? last4;
  int? expiryMonth;
  int? expiryYear;
  String? avsAddress;
  String? avsZip;
  String? paymentMethodType;

  ViewDebitCardListResponse({
    this.id,
    this.customerId,
    this.name,
    this.createdAt,
    this.cardType,
    this.last4,
    this.expiryMonth,
    this.expiryYear,
    this.avsAddress,
    this.avsZip,
    this.paymentMethodType,
  });

  ViewDebitCardListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    createdAt = json['created_at'];
    cardType = json['card_type'];
    last4 = json['last4'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    avsAddress = json['avs_address'];
    avsZip = json['avs_zip'];
    paymentMethodType = json['payment_method_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['card_type'] = cardType;
    data['last4'] = last4;
    data['expiry_month'] = expiryMonth;
    data['expiry_year'] = expiryYear;
    data['avs_address'] = avsAddress;
    data['avs_zip'] = avsZip;
    data['payment_method_type'] = paymentMethodType;
    return data;
  }
}

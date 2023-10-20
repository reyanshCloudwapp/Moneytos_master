// class TransactionChargeRequest {
//   double? amount;
//   AmountDetails? amountDetails;
//   String? name;
//   Customer? customer;
//   BillingInfo? billingInfo;
//   int? expiryMonth;
//   int? expiryYear;
//   String? cvv2;
//   String? card;
//   bool? capture;
//   bool? saveCard;
//
//   TransactionChargeRequest(
//       {this.amount,
//         this.amountDetails,
//         this.name,
//         this.customer,
//         this.billingInfo,
//         this.expiryMonth,
//         this.expiryYear,
//         this.cvv2,
//         this.card,
//         this.capture,
//         this.saveCard});
//
//   TransactionChargeRequest.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'];
//     amountDetails = json['amount_details'] != null
//         ? new AmountDetails.fromJson(json['amount_details'])
//         : null;
//     name = json['name'];
//     customer = json['customer'] != null
//         ? new Customer.fromJson(json['customer'])
//         : null;
//     billingInfo = json['billing_info'] != null
//         ? new BillingInfo.fromJson(json['billing_info'])
//         : null;
//     expiryMonth = json['expiry_month'];
//     expiryYear = json['expiry_year'];
//     cvv2 = json['cvv2'];
//     card = json['card'];
//     capture = json['capture'];
//     saveCard = json['save_card'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount'] = this.amount;
//     if (this.amountDetails != null) {
//       data['amount_details'] = this.amountDetails!.toJson();
//     }
//     data['name'] = this.name;
//     if (this.customer != null) {
//       data['customer'] = this.customer!.toJson();
//     }
//     if (this.billingInfo != null) {
//       data['billing_info'] = this.billingInfo!.toJson();
//     }
//     data['expiry_month'] = this.expiryMonth;
//     data['expiry_year'] = this.expiryYear;
//     data['cvv2'] = this.cvv2;
//     data['card'] = this.card;
//     data['capture'] = this.capture;
//     data['save_card'] = this.saveCard;
//     return data;
//   }
// }
//
// class AmountDetails {
//   int? tax;
//   int? surcharge;
//   int? shipping;
//   int? tip;
//   int? discount;
//
//   AmountDetails(
//       {this.tax, this.surcharge, this.shipping, this.tip, this.discount});
//
//   AmountDetails.fromJson(Map<String, dynamic> json) {
//     tax = json['tax'];
//     surcharge = json['surcharge'];
//     shipping = json['shipping'];
//     tip = json['tip'];
//     discount = json['discount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tax'] = this.tax;
//     data['surcharge'] = this.surcharge;
//     data['shipping'] = this.shipping;
//     data['tip'] = this.tip;
//     data['discount'] = this.discount;
//     return data;
//   }
// }
//
// class Customer {
//   bool? sendReceipt;
//   String? email;
//   String? fax;
//   String? identifier;
//   int? customerId;
//
//   Customer(
//       {this.sendReceipt,
//         this.email,
//         this.fax,
//         this.identifier,
//         this.customerId});
//
//   Customer.fromJson(Map<String, dynamic> json) {
//     sendReceipt = json['send_receipt'];
//     email = json['email'];
//     fax = json['fax'];
//     identifier = json['identifier'];
//     customerId = json['customer_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['send_receipt'] = this.sendReceipt;
//     data['email'] = this.email;
//     data['fax'] = this.fax;
//     data['identifier'] = this.identifier;
//     data['customer_id'] = this.customerId;
//     return data;
//   }
// }
//
// class BillingInfo {
//   String? firstName;
//   String? lastName;
//   String? street;
//   String? street2;
//   String? state;
//   String? city;
//   String? zip;
//   String? country;
//   String? phone;
//
//   BillingInfo(
//       {this.firstName,
//         this.lastName,
//         this.street,
//         this.street2,
//         this.state,
//         this.city,
//         this.zip,
//         this.country,
//         this.phone});
//
//   BillingInfo.fromJson(Map<String, dynamic> json) {
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     street = json['street'];
//     street2 = json['street2'];
//     state = json['state'];
//     city = json['city'];
//     zip = json['zip'];
//     country = json['country'];
//     phone = json['phone'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['street'] = this.street;
//     data['street2'] = this.street2;
//     data['state'] = this.state;
//     data['city'] = this.city;
//     data['zip'] = this.zip;
//     data['country'] = this.country;
//     data['phone'] = this.phone;
//     return data;
//   }
// }

class TransactionChargeRequest {
  double? amount;
  AmountDetails? amountDetails;
  BillingInfo? billingInfo;
  String? source;
  bool? capture;
  String? cvv2;

  TransactionChargeRequest({
    this.amount,
    this.amountDetails,
    this.billingInfo,
    this.source,
    this.capture,
    this.cvv2,
  });

  TransactionChargeRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountDetails = json['amount_details'] != null
        ? new AmountDetails.fromJson(json['amount_details'])
        : null;
    billingInfo = json['billing_info'] != null
        ? new BillingInfo.fromJson(json['billing_info'])
        : null;
    source = json['source'];
    capture = json['capture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    if (amountDetails != null) {
      data['amount_details'] = amountDetails!.toJson();
    }
    if (billingInfo != null) {
      data['billing_info'] = billingInfo!.toJson();
    }
    data['source'] = source;
    data['capture'] = capture;
    return data;
  }
}

class AmountDetails {
  int? tax;
  int? surcharge;
  int? shipping;
  int? tip;
  int? discount;

  AmountDetails(
      {this.tax, this.surcharge, this.shipping, this.tip, this.discount});

  AmountDetails.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    surcharge = json['surcharge'];
    shipping = json['shipping'];
    tip = json['tip'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tax'] = tax;
    data['surcharge'] = surcharge;
    data['shipping'] = shipping;
    data['tip'] = tip;
    data['discount'] = discount;
    return data;
  }
}

class BillingInfo {
  String? firstName;
  String? lastName;
  String? company;
  String? street;
  String? street2;
  String? state;
  String? city;
  String? zip;
  String? country;
  String? phone;

  BillingInfo(
      {this.firstName,
      this.lastName,
      this.company,
      this.street,
      this.street2,
      this.state,
      this.city,
      this.zip,
      this.country,
      this.phone});

  BillingInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    street = json['street'];
    street2 = json['street2'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['street'] = street;
    data['street2'] = street2;
    data['state'] = state;
    data['city'] = city;
    data['zip'] = zip;
    data['country'] = country;
    data['phone'] = phone;
    return data;
  }
}

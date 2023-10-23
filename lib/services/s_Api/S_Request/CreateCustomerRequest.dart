class CreateCustomerRequest {
  String? identifier;
  String? customerNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? website;
  String? phone;
  String? alternatePhone;
  CreateCustomerBillingInfo? billingInfo;
  bool? active;

  CreateCustomerRequest({
    this.identifier,
    this.customerNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.website,
    this.phone,
    this.alternatePhone,
    this.billingInfo,
    this.active,
  });

  CreateCustomerRequest.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    customerNumber = json['customer_number'];
    firstName = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    website = json['website'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    billingInfo = json['billing_info'] != null
        ? CreateCustomerBillingInfo.fromJson(json['billing_info'])
        : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['customer_number'] = customerNumber;
    data['name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['website'] = website;
    data['phone'] = phone;
    data['alternate_phone'] = alternatePhone;
    if (billingInfo != null) {
      data['billing_info'] = billingInfo!.toJson();
    }
    data['active'] = active;
    return data;
  }
}

class CreateCustomerBillingInfo {
  String? firstName;
  String? lastName;
  String? street;
  String? street2;
  String? state;
  String? city;
  String? zip;
  String? country;
  String? phone;

  CreateCustomerBillingInfo({
    this.firstName,
    this.lastName,
    this.street,
    this.street2,
    this.state,
    this.city,
    this.zip,
    this.country,
    this.phone,
  });

  CreateCustomerBillingInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['name'];
    lastName = json['last_name'];
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

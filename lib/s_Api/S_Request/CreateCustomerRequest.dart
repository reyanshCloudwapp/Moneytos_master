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

  CreateCustomerRequest(
      {this.identifier,
        this.customerNumber,
        this.firstName,
        this.lastName,
        this.email,
        this.website,
        this.phone,
        this.alternatePhone,
        this.billingInfo,
        this.active});

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
        ? new CreateCustomerBillingInfo.fromJson(json['billing_info'])
        : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['customer_number'] = this.customerNumber;
    data['name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    if (this.billingInfo != null) {
      data['billing_info'] = this.billingInfo!.toJson();
    }
    data['active'] = this.active;
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

  CreateCustomerBillingInfo(
      {this.firstName,
        this.lastName,
        this.street,
        this.street2,
        this.state,
        this.city,
        this.zip,
        this.country,
        this.phone});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['street'] = this.street;
    data['street2'] = this.street2;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    return data;
  }
}

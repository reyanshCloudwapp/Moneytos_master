class LocationResponse {
  bool? status;
  String? message;
  Data? data;

  LocationResponse({this.status, this.message, this.data});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Locationdata>? locationdata;

  Data({this.locationdata});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['locationdata'] != null) {
      locationdata = <Locationdata>[];
      json['locationdata'].forEach((v) {
        locationdata!.add(Locationdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (locationdata != null) {
      data['locationdata'] = locationdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locationdata {
  String? agentCode;
  String? agentName;
  String? cityCode;
  String? countryCode;
  String? address;
  String? countryName;
  String? cityName;
  String? telephone;
  String? mobile;
  String? contactPerson;
  String? email;

  Locationdata({
    this.agentCode,
    this.agentName,
    this.cityCode,
    this.countryCode,
    this.address,
    this.countryName,
    this.cityName,
    this.telephone,
    this.mobile,
    this.contactPerson,
    this.email,
  });

  Locationdata.fromJson(Map<String, dynamic> json) {
    agentCode = json['AgentCode'];
    agentName = json['AgentName'];
    cityCode = json['CityCode'];
    countryCode = json['CountryCode'];
    address = json['Address'];
    countryName = json['CountryName'];
    cityName = json['CityName'];
    telephone = json['Telephone'];
    mobile = json['Mobile'];
    contactPerson = json['ContactPerson'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AgentCode'] = agentCode;
    data['AgentName'] = agentName;
    data['CityCode'] = cityCode;
    data['CountryCode'] = countryCode;
    data['Address'] = address;
    data['CountryName'] = countryName;
    data['CityName'] = cityName;
    data['Telephone'] = telephone;
    data['Mobile'] = mobile;
    data['ContactPerson'] = contactPerson;
    data['Email'] = email;
    return data;
  }
}

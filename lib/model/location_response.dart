class LocationResponse {
  bool? status;
  String? message;
  Data? data;

  LocationResponse({this.status, this.message, this.data});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
        locationdata!.add(new Locationdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locationdata != null) {
      data['locationdata'] = this.locationdata!.map((v) => v.toJson()).toList();
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

  Locationdata(
      {this.agentCode,
        this.agentName,
        this.cityCode,
        this.countryCode,
        this.address,
        this.countryName,
        this.cityName,
        this.telephone,
        this.mobile,
        this.contactPerson,
        this.email});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AgentCode'] = this.agentCode;
    data['AgentName'] = this.agentName;
    data['CityCode'] = this.cityCode;
    data['CountryCode'] = this.countryCode;
    data['Address'] = this.address;
    data['CountryName'] = this.countryName;
    data['CityName'] = this.cityName;
    data['Telephone'] = this.telephone;
    data['Mobile'] = this.mobile;
    data['ContactPerson'] = this.contactPerson;
    data['Email'] = this.email;
    return data;
  }
}

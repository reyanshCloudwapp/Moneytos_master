// To parse this JSON data, do
//
//     final getOperatorResponse = getOperatorResponseFromJson(jsonString);

import 'dart:convert';

GetOperatorResponse getOperatorResponseFromJson(String str) => GetOperatorResponse.fromJson(json.decode(str));

String getOperatorResponseToJson(GetOperatorResponse data) => json.encode(data.toJson());

class GetOperatorResponse {
  bool? status;
  String? message;
  OperatorData? data;

  GetOperatorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetOperatorResponse.fromJson(Map<String, dynamic> json) => GetOperatorResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OperatorData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OperatorData {
  List<MobileOperator>? mobileOperators;

  OperatorData({
    this.mobileOperators,
  });

  factory OperatorData.fromRawJson(String str) => OperatorData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OperatorData.fromJson(Map<String, dynamic> json) => OperatorData(
    mobileOperators: json["mobileOperators"] == null ? [] : List<MobileOperator>.from(json["mobileOperators"]!.map((x) => MobileOperator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mobileOperators": mobileOperators == null ? [] : List<dynamic>.from(mobileOperators!.map((x) => x.toJson())),
  };
}

class MobileOperator {
  int? id;
  String? countryIso2;
  String? mobileOperatorOperator;
  String? jubaNominatedCode;

  MobileOperator({
    this.id,
    this.countryIso2,
    this.mobileOperatorOperator,
    this.jubaNominatedCode
  });

  factory MobileOperator.fromRawJson(String str) => MobileOperator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileOperator.fromJson(Map<String, dynamic> json) => MobileOperator(
    id: json["id"],
    countryIso2: json["country_iso2"],
    mobileOperatorOperator: json["operator"],
      jubaNominatedCode : json['juba_NominatedCode']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_iso2": countryIso2,
    "operator": mobileOperatorOperator,
    "juba_NominatedCode": jubaNominatedCode,

  };
}

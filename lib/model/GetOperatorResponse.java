// To parse this JSON data, do
//
//     final getOperatorResponse = getOperatorResponseFromJson(jsonString);

import 'dart:convert';

class GetOperatorResponse {
    bool? status;
    String? message;
    Data? data;

    GetOperatorResponse({
        this.status,
        this.message,
        this.data,
    });

    factory GetOperatorResponse.fromRawJson(String str) => GetOperatorResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetOperatorResponse.fromJson(Map<String, dynamic> json) => GetOperatorResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    List<MobileOperator>? mobileOperators;

    Data({
        this.mobileOperators,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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

    MobileOperator({
        this.id,
        this.countryIso2,
        this.mobileOperatorOperator,
    });

    factory MobileOperator.fromRawJson(String str) => MobileOperator.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MobileOperator.fromJson(Map<String, dynamic> json) => MobileOperator(
        id: json["id"],
        countryIso2: json["country_iso2"],
        mobileOperatorOperator: json["operator"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country_iso2": countryIso2,
        "operator": mobileOperatorOperator,
    };
}

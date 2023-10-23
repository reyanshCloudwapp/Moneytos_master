class GetStatusResponse {
  List<Statuses>? statuses;

  GetStatusResponse({this.statuses});

  GetStatusResponse.fromJson(Map<String, dynamic> json) {
    if (json['statuses'] != null) {
      statuses = <Statuses>[];
      json['statuses'].forEach((v) {
        statuses!.add(Statuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statuses != null) {
      data['statuses'] = statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statuses {
  String? status;
  String? changedDate;

  Statuses({this.status, this.changedDate});

  Statuses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    changedDate = json['changedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['changedDate'] = changedDate;
    return data;
  }
}

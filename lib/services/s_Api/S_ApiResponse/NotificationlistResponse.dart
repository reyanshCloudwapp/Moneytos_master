class NotificationlistResponse {
  bool? status;
  String? message;
  Data? data;

  NotificationlistResponse({this.status, this.message, this.data});

  NotificationlistResponse.fromJson(Map<String, dynamic> json) {
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
  List<NotificationData>? notificationData;

  Data({this.notificationData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notificationData'] != null) {
      notificationData = <NotificationData>[];
      json['notificationData'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationData != null) {
      data['notificationData'] =
          notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? title;
  String? description;
  String? createdAt;

  NotificationData({this.title, this.description, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}

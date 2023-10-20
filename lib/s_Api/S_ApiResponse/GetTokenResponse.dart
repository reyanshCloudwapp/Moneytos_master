class GetTokenResponse {
  String? accessToken;
  int? expiresIn;
  String? tokenType;

  GetTokenResponse({this.accessToken, this.expiresIn, this.tokenType});

  GetTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['token_type'] = this.tokenType;
    return data;
  }
}

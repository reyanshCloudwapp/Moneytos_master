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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    return data;
  }
}

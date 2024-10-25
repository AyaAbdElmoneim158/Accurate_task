class LoginResponse {
  final String? token;

  LoginResponse({
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['login']['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': {
        'token': token,
      },
    };
  }
}

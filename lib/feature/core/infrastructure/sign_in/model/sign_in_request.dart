import 'dart:convert';

SignInRequest signInRequestFromJson(String str) =>
    SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  SignInRequest({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
    username: json["identifier"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": username,
    "password": password,
  };
}

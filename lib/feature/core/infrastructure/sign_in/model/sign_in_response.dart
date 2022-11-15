import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    required this.meta,
    required this.data,
  });

  Meta meta;
  Data data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.authToken,
    required this.refreshToken,
  });

  String authToken;
  String refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authToken: json["auth_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "refresh_token": refreshToken,
      };
}

class Meta {
  Meta({
    required this.status,
    required this.code,
    required this.message,
  });

  int status;
  String code;
  String message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}

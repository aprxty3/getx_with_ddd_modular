import 'dart:convert';

RequestResetPassResponse requestResetPassResponseFromJson(String str) =>
    RequestResetPassResponse.fromJson(json.decode(str));

String requestResetPassResponseToJson(RequestResetPassResponse data) =>
    json.encode(data.toJson());

class RequestResetPassResponse {
  RequestResetPassResponse({
    required this.meta,
  });

  Meta meta;

  factory RequestResetPassResponse.fromJson(Map<String, dynamic> json) =>
      RequestResetPassResponse(
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
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

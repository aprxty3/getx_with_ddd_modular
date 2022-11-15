import 'dart:convert';

RequestResetPassRequest requestResetPassRequestFromJson(String str) =>
    RequestResetPassRequest.fromJson(json.decode(str));

String requestResetPassRequestToJson(RequestResetPassRequest data) =>
    json.encode(data.toJson());

class RequestResetPassRequest {
  RequestResetPassRequest({
    required this.email,
  });

  String email;

  factory RequestResetPassRequest.fromJson(Map<String, dynamic> json) =>
      RequestResetPassRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

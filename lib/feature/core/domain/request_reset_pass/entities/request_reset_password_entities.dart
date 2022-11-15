import '../value_object/request_reset_password_email.dart';

class RequestResetPasswordEntities {
  final RequestResetPassEmail _resetEmail;

  RequestResetPasswordEntities({
    required RequestResetPassEmail reqResetPassEmail,
  }) : _resetEmail = reqResetPassEmail;

  RequestResetPassEmail get reqResetPassEmail => _resetEmail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestResetPasswordEntities &&
          runtimeType == other.runtimeType &&
          _resetEmail == other._resetEmail;

  @override
  int get hashCode => _resetEmail.hashCode;
}

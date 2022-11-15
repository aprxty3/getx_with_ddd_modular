import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/value_object/sign_in_username.dart';

import '../value_object/sign_in_password.dart';

class SignInEntities {
  final SignInUsername _username;
  final SignInPassword _password;

  SignInEntities(
      {required SignInUsername signInUsername,
      required SignInPassword signInPassword})
      : _username = signInUsername,
        _password = signInPassword;

  SignInUsername get signInUsername => _username;

  SignInPassword get signInPassword => _password;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInEntities &&
          runtimeType == other.runtimeType &&
          _username == other._username &&
          _password == other._password;

  @override
  int get hashCode => _username.hashCode ^ _password.hashCode;
}

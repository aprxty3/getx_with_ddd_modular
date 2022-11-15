import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/entities/sign_in_entities.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/interface/sign_in_factory_base.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/value_object/sign_in_password.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/value_object/sign_in_username.dart';

class SignInFactory implements SignInFactoryBase {
  @override
  SignInEntities create({
    required SignInUsername username,
    required SignInPassword password,
  }) {
    return SignInEntities(
      signInUsername: username,
      signInPassword: password,
    );
  }
}

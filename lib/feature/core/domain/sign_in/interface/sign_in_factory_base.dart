import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/value_object/sign_in_username.dart';

import '../entities/sign_in_entities.dart';
import '../value_object/sign_in_password.dart';

abstract class SignInFactoryBase {
  SignInEntities create({
    required SignInUsername username,
    required SignInPassword password,
  });
}

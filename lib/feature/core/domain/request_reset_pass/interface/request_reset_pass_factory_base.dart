import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/entities/request_reset_password_entities.dart';

import '../value_object/request_reset_password_email.dart';

abstract class RequestResetPassFactoryBase {
  RequestResetPasswordEntities requestReset({
    required RequestResetPassEmail reqResetPassEmail,
  });
}

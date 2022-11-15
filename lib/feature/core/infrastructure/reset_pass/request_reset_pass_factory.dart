import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/entities/request_reset_password_entities.dart';

import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/value_object/request_reset_password_email.dart';

import '../../domain/request_reset_pass/interface/request_reset_pass_factory_base.dart';

class RequestResetPassFactory implements RequestResetPassFactoryBase {
  @override
  RequestResetPasswordEntities requestReset(
      {required RequestResetPassEmail reqResetPassEmail}) {
    return RequestResetPasswordEntities(reqResetPassEmail: reqResetPassEmail);
  }
}

import 'package:dartz/dartz.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/entities/request_reset_password_entities.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/model/request_reset_pass_email_response.dart';

import '../../../../../app/common/exception.dart';

abstract class RequestResetPassRepositoryBase {
  Future<Either<GenericException, RequestResetPassResponse>>
      reqResetPassByEmail(RequestResetPasswordEntities reqResetPassEntities);
}

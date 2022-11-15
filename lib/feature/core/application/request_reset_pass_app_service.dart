import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/value_object/request_reset_password_email.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/model/request_reset_pass_email_response.dart';

import '../../../app/common/exception.dart';
import '../domain/request_reset_pass/interface/request_reset_pass_factory_base.dart';
import '../domain/request_reset_pass/interface/request_reset_pass_repository_base.dart';
import '../infrastructure/reset_pass/repository/request_reset_pass_repository.dart';
import '../infrastructure/reset_pass/request_reset_pass_factory.dart';

class RequestResetPassAppService {
  final RequestResetPassFactoryBase _factory =
      Get.find<RequestResetPassFactory>();
  final RequestResetPassRepositoryBase _repository =
      Get.find<RequestResetPassRepository>();

  Future<Either<GenericException, RequestResetPassResponse>>
      reqResetPassByEmail({required String email}) async {
    final sendEmail =
        _factory.requestReset(reqResetPassEmail: RequestResetPassEmail(email));

    final res = await _repository.reqResetPassByEmail(sendEmail);
    return res.fold((l) => Left(l), (r) => Right(r));
  }
}

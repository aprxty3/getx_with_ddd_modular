import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/app/common/exception.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/request_reset_pass/entities/request_reset_password_entities.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/data_source/request_reset_data_source.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/model/request_reset_pass_email_request.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/model/request_reset_pass_email_response.dart';
import '../../../domain/request_reset_pass/interface/request_reset_pass_repository_base.dart';

class RequestResetPassRepository implements RequestResetPassRepositoryBase {
  final remoteDataSource = Get.find<RequestResetPassDataSource>();

  @override
  Future<Either<GenericException, RequestResetPassResponse>>
      reqResetPassByEmail(
          RequestResetPasswordEntities reqResetPassEntities) async {
    final res = await remoteDataSource.reqResetPassByEmail(
      reqResetPasswordRequest: RequestResetPassRequest(
          email: reqResetPassEntities.reqResetPassEmail.value),
    );

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}

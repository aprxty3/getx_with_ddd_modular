import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/model/request_reset_pass_email_response.dart';

import '../../../../../app/common/exception.dart';
import '../../../../../app/network/provider/api_provider.dart';
import '../model/request_reset_pass_email_request.dart';

class RequestResetPassDataSource {
  final _apiProvider = Get.find<APIProvider>();

  Future<Either<GenericException, RequestResetPassResponse>>
      reqResetPassByEmail(
          {required RequestResetPassRequest reqResetPasswordRequest}) async {
    //TODO : can fill the URL
    return await _apiProvider
        .postData('URLNyaaa yaaa', reqResetPasswordRequest.toJson())
        .then(
          (value) => value.fold(
            (l) => Left(l),
            (res) {
              if (res.statusCode != 200) {
                return Left(
                  ServerRequestException(
                    code: ExceptionCode.serverFailure,
                    value: res.data['meta']['status'],
                  ),
                );
              } else {
                return Right(
                  RequestResetPassResponse.fromJson(res.data),
                );
              }
            },
          ),
        );
  }
}

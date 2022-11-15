import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/app/common/exception.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/entities/sign_in_entities.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/interface/sign_in_repository_base.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/sign_in/data_source/sign_in_remote_data_source.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/sign_in/model/sign_in_request.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/sign_in/model/sign_in_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utility/shared/constants/storage.dart';

class SignInRepository implements SignInRepositoryBase {
  final remoteDataSource = Get.find<SignInRemoteDataSource>();
  final storage = Get.find<SharedPreferences>();

  @override
  Future<Either<GenericException, SignInResponse>> signInByUsername(
      SignInEntities signInEntities) async {
    final res = await remoteDataSource.signInUsername(
      signInRequest: SignInRequest(
          username: signInEntities.signInUsername.value,
          password: signInEntities.signInPassword.value),
    );

    return res.fold((l) => Left(l), (res) {
      storage.setString(StorageConstants.token, res.data.authToken);
      storage.setString(StorageConstants.refreshToken, res.data.refreshToken);
      return Right(res);
    });
  }
}

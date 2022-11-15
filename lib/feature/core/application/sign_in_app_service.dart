import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/domain/sign_in/value_object/sign_in_username.dart';

import '../../../app/common/exception.dart';
import '../domain/sign_in/interface/sign_in_factory_base.dart';
import '../domain/sign_in/interface/sign_in_repository_base.dart';
import '../domain/sign_in/value_object/sign_in_password.dart';
import '../infrastructure/sign_in/model/sign_in_response.dart';
import '../infrastructure/sign_in/repository/sign_in_repository.dart';
import '../infrastructure/sign_in/sign_in_factory.dart';

class SignInAppService {
  final SignInFactoryBase _factory = Get.find<SignInFactory>();
  final SignInRepositoryBase _repository = Get.find<SignInRepository>();

  //TODO : you can use this function on your logic files
  Future<Either<GenericException, SignInResponse>> signInByUsername({
    required String username,
    required String password,
  }) async {
    final signIn = _factory.create(
      username: SignInUsername(username),
      password: SignInPassword(password),
    );

    final res = await _repository.signInByUsername(signIn);

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}

import 'package:dartz/dartz.dart';

import '../../../../../app/common/exception.dart';
import '../../../infrastructure/sign_in/model/sign_in_response.dart';
import '../entities/sign_in_entities.dart';

abstract class SignInRepositoryBase {
  Future<Either<GenericException, SignInResponse>> signInByUsername(
      SignInEntities signInEntities);
}

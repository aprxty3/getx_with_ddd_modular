import 'package:dartz/dartz.dart';

import '../../../../../app/common/exception.dart';
import '../../../../../app/network/provider/api_provider.dart';
import '../model/sign_in_request.dart';
import '../model/sign_in_response.dart';

class SignInRemoteDataSource {
  final APIProvider _apiProvider;

  SignInRemoteDataSource({
    required APIProvider apiProvider,
  }) : _apiProvider = apiProvider;


  //TODO : you can fill the URL on this variable
  static const String apiUrl = 'URLnyaa DI ISI';

  Future<Either<GenericException, SignInResponse>> signInUsername(
      {required SignInRequest signInRequest}) async {
    return await _apiProvider.postData(apiUrl, signInRequest.toJson()).then(
          (value) => value.fold(
            (l) => Left(l),
            (res) {
              if (res.statusCode != 200) {
                return Left(
                  InvalidAuthInputException(
                      code: ExceptionCode.unknown, value: ''),
                );
              } else {
                return Right(
                  SignInResponse.fromJson(
                    res.data,
                  ),
                );
              }
            },
          ),
        );
  }
}

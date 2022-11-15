import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/application/request_reset_pass_app_service.dart';
import 'package:getx_with_ddd_modular/feature/core/presentation/sign_in/sign_in_ui.dart';

import 'reset_password_state.dart';

class ResetPasswordLogic extends GetxController {
  final ResetPasswordState state = ResetPasswordState();

  //TODO : you can access the AppService like this
  final _appCore = Get.find<RequestResetPassAppService>();

  //TODO : provide an API
  resetPass() async {
    //TODO : if have an URL API, you can use this
    // final res = await _appCore.reqResetPassByEmail(
    //     email: state.emailController.value.text);

//TODO : if statusCode == 200, you can use this function
//     res.fold((l) => Left(l), (r) {
//       Get.offAndToNamed(SignInUi.namePath);
//       Right(r);
//     });
    Get.offAndToNamed(SignInUi.namePath);
  }
}

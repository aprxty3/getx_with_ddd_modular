import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/application/sign_in_app_service.dart';
import 'package:getx_with_ddd_modular/feature/main/presentation/main_home_page/main_home_page_ui.dart';

import 'sign_in_state.dart';

class SignInLogic extends GetxController {
  final SignInState state = SignInState();

  //TODO : you can access the AppService like this
  final _app = Get.find<SignInAppService>();

  signIn() async {
    //TODO : if have an URL API, you can use this
    // final res = await _app.signInByUsername(
    //   username: state.usernameController.value.text,
    //   password: state.passwordController.value.text,
    // );

    //TODO : if statusCode == 200, you can use this function
    // res.fold((l) => Left(l), (r) {
    //   Get.offAndToNamed(MainHomePageUi.namePath);
    //   Right(r);
    // });

    Get.offAndToNamed(MainHomePageUi.namePath);
  }
}

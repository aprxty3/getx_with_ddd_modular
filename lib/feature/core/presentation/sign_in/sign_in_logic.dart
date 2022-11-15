import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/core/application/sign_in_app_service.dart';
import 'package:getx_with_ddd_modular/feature/main/presentation/main_home_page/main_home_page_ui.dart';

import 'sign_in_state.dart';

class SignInLogic extends GetxController {
  final SignInState state = SignInState();

  //TODO : you can access the AppService like this
  final _app = Get.find<SignInAppService>();

  signIn() async {
    final res = await _app.signInByUsername(
      username: state.usernameController.value.text,
      password: state.passwordController.value.text,
    );

    return res.fold((l) {
      Get.offAndToNamed(MainHomePageUi.namePath);
    }, (r) {
      Get.offAndToNamed(MainHomePageUi.namePath);
    });
  }
}

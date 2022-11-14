import 'package:get/get.dart';

import '../feature/core/reset_password/reset_password_binding.dart';
import '../feature/core/reset_password/reset_password_ui.dart';
import '../feature/core/sign_in/sign_in_binding.dart';
import '../feature/core/sign_in/sign_in_ui.dart';
import '../feature/core/splash_screen/splash_screen_binding.dart';
import '../feature/core/splash_screen/splash_screen_ui.dart';

class AppRouter {
  static const initial = SplashScreenUi.namePath;

  static final routes = [
    GetPage(
      name: SplashScreenUi.namePath,
      page: () => SplashScreenUi(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: SignInUi.namePath,
      page: () => SignInUi(),
      binding: SignInBinding(),
    ),

    GetPage(
      name: ResetPasswordUi.namePath,
      page: () => ResetPasswordUi(),
      binding: ResetPasswordBinding(),
    ),
    // GetPage(
    //   name: MainCoreUi.namePath,
    //   page: () => MainCoreUi(),
    //   binding: MainCoreBinding(),
    // ),
  ];
}

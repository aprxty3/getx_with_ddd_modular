import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/feature/main/presentation/main_home_page/main_home_page_binding.dart';
import 'package:getx_with_ddd_modular/feature/main/presentation/main_home_page/main_home_page_ui.dart';

import '../feature/core/presentation/reset_password/reset_password_binding.dart';
import '../feature/core/presentation/reset_password/reset_password_ui.dart';
import '../feature/core/presentation/sign_in/sign_in_binding.dart';
import '../feature/core/presentation/sign_in/sign_in_ui.dart';
import '../feature/core/presentation/splash_screen/splash_screen_binding.dart';
import '../feature/core/presentation/splash_screen/splash_screen_ui.dart';

class AppRouter {
  static const initial = SplashScreenUi.namePath;

  //TODO : add an UI and Binding files on this Route Management file
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
    GetPage(
      name: MainHomePageUi.namePath,
      page: () => MainHomePageUi(),
      binding: MainHomePageBinding(),
    ),
  ];
}


class AppRouter {
  static const initial = SplashScreenUi.namePath;

  static final routes = [
    GetPage(
      name: SplashScreenUi.namePath,
      page: () => SplashScreenUi(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: SigninUi.namePath,
      page: () => SigninUi(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: RequestResetPasswordUi.namePath,
      page: () => RequestResetPasswordUi(),
      binding: RequestResetPasswordBinding(),
    ),
    GetPage(
      name: ResetPasswordUi.namePath,
      page: () => ResetPasswordUi(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: MainCoreUi.namePath,
      page: () => MainCoreUi(),
      binding: MainCoreBinding(),
    ),

  ];
}

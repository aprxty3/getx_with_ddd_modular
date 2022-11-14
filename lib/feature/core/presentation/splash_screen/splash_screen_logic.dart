import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import '../sign_in/sign_in_ui.dart';
import 'splash_screen_state.dart';

class SplashScreenLogic extends GetxController {
  final SplashScreenState state = SplashScreenState();

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamedUntil(SignInUi.namePath, (route) => false);
  }
}

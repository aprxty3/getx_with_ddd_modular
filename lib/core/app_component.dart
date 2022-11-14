import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/lang/translation_service.dart';
import '../app/theme/theme_data.dart';
import 'app_provider.dart';
import 'app_route.dart';
import 'app_store_application.dart';
import 'binding.dart';
import 'env.dart';

class AppComponent extends StatelessWidget {
  final AppStoreApplication _application;

  const AppComponent(this._application, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.log(Env.value.appName);

    final myApp = GetMaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      enableLog: Env.value.environmentType == EnvType.development,
      getPages: AppRouter.routes,
      initialRoute: AppRouter.initial,
      defaultTransition: Transition.noTransition,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: Env.value.appName,
      color: Env.value.primarySwatch,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.light,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );

    final appProvider = AppProvider(application: _application, child: myApp);
    return appProvider;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app_component.dart';
import 'app_store_application.dart';
import 'dependency_injection.dart';

enum EnvType { development, staging, production, testing }

class Env {
  static late Env value;

  String get appName => '';

  String get baseUrl => '';

  String get articleUrl => '';

  String get socketUrl => '';

  String get websocket => '';

  String get tnc => '';

  Color get primarySwatch => Colors.teal;

  EnvType environmentType = EnvType.development;

  // Database Config
  int get dbVersion => 1;

  String get dbName => '';

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await DenpendencyInjection.init();

    var application = AppStoreApplication();
    await application.onCreate();
    initializeDateFormatting('id_ID', null)
        .then((_) => runApp(AppComponent(application)));
  }
}

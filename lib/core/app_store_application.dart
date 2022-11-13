import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/utility/framework/application.dart';
import 'package:getx_with_ddd_modular/utility/log/log.dart';
import 'package:logging/logging.dart';

import 'env.dart';

class AppStoreApplication implements Application {
  @override
  Future<void> onCreate() async {
    _initLog();
  }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.testing:
      case EnvType.development:
      case EnvType.staging:
        break;
      case EnvType.production:
        Log.setLevel(Level.INFO);
        break;
    }
  }

  @override
  Future<void> onTerminate() async {
    Get.log('''
=============================================================
               APP KILLED
=============================================================
''');
  }
}

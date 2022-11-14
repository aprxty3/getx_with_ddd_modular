import 'package:get/get.dart';

import '../app/network/provider/db_provider.dart';
import '../app/network/provider/file_manager_provider.dart';
import '../utility/shared/services/storage_service.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => FileManagerProvider().init());
    await Get.putAsync(() => DBProvider().registerAdapter());

    /// Can Use DBMS Provider when on Isar have Schema
    // await Get.putAsync(() async => DbmsProvider(isar: await initIsar()));
  }
}

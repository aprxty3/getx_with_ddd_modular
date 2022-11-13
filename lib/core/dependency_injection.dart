import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/app/network/provider/db_provider.dart';
import 'package:getx_with_ddd_modular/app/network/provider/file_manager_provider.dart';
import 'package:getx_with_ddd_modular/utility/shared/services/storage_service.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => FileManagerProvider().init());
    await Get.putAsync(() => DBProvider().registerAdapter());
  }
}

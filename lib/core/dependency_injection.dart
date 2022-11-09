
import 'package:get/get.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => FileManagerProvider().init());
    await Get.putAsync(() => DBProvider().registerAdapter());
    await Get.putAsync(() => DLProvider().init());
  }
}

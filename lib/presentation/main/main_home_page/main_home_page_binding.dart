import 'package:get/get.dart';

import 'main_home_page_logic.dart';

class MainHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomePageLogic());
  }
}

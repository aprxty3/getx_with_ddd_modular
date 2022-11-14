import 'package:get/get.dart';

import 'profile_page_logic.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageLogic());
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_home_page_logic.dart';

class MainHomePageUi extends StatelessWidget {
  final logic = Get.find<MainHomePageLogic>();
  final state = Get.find<MainHomePageLogic>().state;

  MainHomePageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

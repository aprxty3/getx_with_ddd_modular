import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_page_logic.dart';

class ProfilePageUi extends StatelessWidget {
  final logic = Get.find<ProfilePageLogic>();
  final state = Get.find<ProfilePageLogic>().state;

  ProfilePageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

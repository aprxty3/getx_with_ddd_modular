import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_in_logic.dart';

class SignInUi extends StatelessWidget {
  static const String namePath = '/sign-in';
  final logic = Get.find<SignInLogic>();
  final state = Get.find<SignInLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

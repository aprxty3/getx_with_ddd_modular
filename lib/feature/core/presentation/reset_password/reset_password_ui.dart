import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reset_password_logic.dart';

class ResetPasswordUi extends StatelessWidget {
  static const String namePath = '/reset-pass';
  final logic = Get.find<ResetPasswordLogic>();
  final state = Get.find<ResetPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

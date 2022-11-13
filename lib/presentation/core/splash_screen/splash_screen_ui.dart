import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'splash_screen_logic.dart';

class SplashScreenUi extends StatelessWidget {
  static const String namePath = '/splash';
  final logic = Get.find<SplashScreenLogic>();
  final state = Get.find<SplashScreenLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Bounce(
          infinite: true,
          duration: const Duration(milliseconds: 1500),
          child: Text('Hahahay Nyoba Fitur dulu'),
        ),
      ),
    );
  }
}

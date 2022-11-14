import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'splash_screen_logic.dart';

class SplashScreenUi extends StatelessWidget {
  static const String namePath = '/splash';
  final logic = Get.find<SplashScreenLogic>();
  final state = Get.find<SplashScreenLogic>().state;

  SplashScreenUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Bounce(
          infinite: true,
          duration: const Duration(milliseconds: 1500),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: const Center(
              child: Text(
                'Kasih logo/icon ya',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

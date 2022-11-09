import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class LoadBar extends GetxService {
  LoadBar() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 4000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 30.0
      ..radius = 10.0
      ..progressColor = ColorConstants.primaryColor
      ..backgroundColor = ColorConstants.white
      ..indicatorColor = ColorConstants.primaryColor
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  void showLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    EasyLoading.show(status: 'Loading...');
  }
}

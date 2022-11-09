import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class DLProvider {
  StreamSubscription? _sub;

  String obtainedLink = '';
  Object? _err;

  init() async {
    //handle incoming links
    _sub = linkStream.listen(
      (String? link) {
        if (link != null) {
          obtainedLink = link;
          _err = null;

          Uri resetLinkUrl = Uri.parse(obtainedLink);
          var uidParam = resetLinkUrl.queryParameters['uid'];
          var tokenParam = resetLinkUrl.queryParameters['token'];

          if (uidParam == null || tokenParam == null) {
            CommonWidget.toast(
                'Link yang digunakan sudah rusak atau tidak berlaku');
          } else {
            Get.toNamed(ResetPasswordUi.namePath,
                arguments: [uidParam, tokenParam]);
          }
        }
      },
      onError: (err) {
        if (err is FormatException) {
          _err = err;
        } else {
          _err = null;
        }

        if (_err != null) {
          CommonWidget.toast('Terjadi Kesalahan');
        }
        SystemNavigator.pop();
      },
    );

    _sub!.cancel();
  }
}

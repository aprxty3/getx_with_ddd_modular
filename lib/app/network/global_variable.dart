import 'package:get/get.dart';

class GlobalVariables extends GetxController {
  var voiceUiStatus = false.obs;

  GlobalVariables() {
    voiceUiStatus.value = true;
  }

  setVoiceUiStatus(bool value) => voiceUiStatus.value = value;
}

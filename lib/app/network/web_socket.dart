import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserPresence { online, busy, away, offline }

class WebSocketService extends GetNotifier {
  WebSocketService() : super('');
  static const tag = 'WebSocketService';

  var pref = Get.find<SharedPreferences>();
  GetSocket ws = GetSocket(Env.value.socketUrl);
  late String? chatToken;
  final _isConnected = GetStream<bool>();

  Stream<bool> get onConnecting => _isConnected.stream;

  @override
  void onInit() {
    super.onInit();

    Get.log('Instance WebSocket onInit called');

    _isConnected.add(false);

    ws.onOpen(() {
      Get.log('$tag onOpen');
      chatToken = pref.getString(StorageConstants.chatToken);

      if (chatToken != null) wsLoginConnecting();

      change(value, status: RxStatus.success());
    });

    ws.onMessage((value) {
      final response = json.decode(value);
      Get.log('WebSocket onMessage : ${jsonEncode(response)}}');

      if (response['msg'] == 'connected') {
        Get.log('RRRREEESSPONSE $response');
      }

      if (response['msg'] == 'collection') {
        Get.log('COOLLECTION $response');
      }
    });

    ws.onClose((close) async {
      Get.log('$tag $close');
      _isConnected.add(false);
      await Future.delayed(const Duration(seconds: 2));

      if (ws.isBlank!) ws.connect();

      change(value, status: RxStatus.error(close.message));
    });

    ws.onError((e) {
      Get.log('WebSocket error called : ${e.reason}');
      change(value, status: RxStatus.error(e.message));
    });

    ws.connect();
    Get.log('$tag connection ${_isConnected.value}');
    super.onInit();
  }

  /// Before requesting any method / subscription you have to send a connect
  /// message, you can read the documentation here :
  /// [https://developer.rocket.chat/reference/api/realtime-api]
  wsLoginConnecting() {
    var connect = '''
    {
      "msg" : "connect",
      "version": "1",
      "support": ["1"]
    }
    ''';
    ws.send(connect);

    var loginRequest = '''
    {
      "msg": "method",
      "method": "login",
      "id": "${generateHash(17)}",
      "params": [
        {"resume": "$chatToken"}
      ]
    }
    ''';

    ws.send(loginRequest);
  }

  /// In order to set the default status we need to call the
  /// UserPresence:setDefaultStatus method passing the status in the parameters
  /// of the call. you can read the documentation here :
  /// [https://developer.rocket.chat/reference/api/realtime-api/method-calls/user-presence]
  void doUserPresence({required UserPresence status}) {
    var presence = '''
    {
      "msg":"method",
      "method":"UserPresence:DefaultStatus",
      "id":"${generateHash(17)}",
      "params": [ "${status.name}"]
    }
    ''';
    ws.send(presence);
  }

  /// Setting a temporary status requires a call to UserPresence:{status} with
  /// empty params. Only away and online are accepted. This method call is useful
  /// when the client identifies that the user is not using the application (and
  /// therefore away) and when he got back.
  /// [https://developer.rocket.chat/reference/api/realtime-api/method-calls/user-presence]
  void doTempUserPresence({required UserPresence status}) {
    var presence = '''
    {
      "msg": "method",
      "method": "UserPresence.${status.name}",
      "id": "${generateHash(17)}"
      "params": [}
    }
    ''';

    ws.send(presence);
  }

  /// Before request any method / subscribetion you must have uniqId [id_call]
  /// for it, this is function return you needed uniqId call socket
  String generateHash(targetLength) {
    var text = '';

    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    text += getRandomString(targetLength);
    return text;
  }
}

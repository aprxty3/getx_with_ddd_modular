// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

import 'core/env.dart';

void main() => Development();

class Development extends Env {
  @override
  final String appName = 'Name Your Project';
  @override
  final String articleUrl = '';
  @override
  final String baseUrl = ''; //dev
  @override
  final String tnc = '';
  @override
  final String socketUrl = ''; // socket.io has connected
  @override
  final String websocket =
      ''; // socket.io reject connecting so websocket handle it

  @override
  final Color primarySwatch = Colors.teal;
  @override
  EnvType environmentType = EnvType.development;

  @override
  final String dbName = 'dev-docApps.db';
}

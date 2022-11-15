// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

import 'core/env.dart';

void main() => Production();

class Production extends Env {
  @override
  final String appName = 'Name Your Project';
  @override
  final String articleUrl = '';
  @override
  final String baseUrl = ''; //dev
  @override
  final String tnc = '';
  @override
  final Color primarySwatch = Colors.teal;
  @override
  EnvType environmentType = EnvType.production;

  @override
  final String dbName = '';
}

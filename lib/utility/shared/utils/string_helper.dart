import 'package:get/get_utils/src/extensions/string_extensions.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}

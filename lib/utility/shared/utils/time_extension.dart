import 'package:flutter/material.dart';

enum TimeOfDayOptions { colon, dot }

extension TimeOfDayConverter on TimeOfDay {
  String to24hours([TimeOfDayOptions? options]) {
    final formatOption = options ?? TimeOfDayOptions.colon;
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return formatOption == TimeOfDayOptions.colon ? "$hour:$min" : "$hour.$min";
  }
}

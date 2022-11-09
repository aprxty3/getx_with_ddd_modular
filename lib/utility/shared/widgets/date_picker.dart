
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


enum DateTimeType { single, multi }

class CustomDatePicker extends StatefulWidget {
  final dynamic state;
  final dynamic logic;
  final List<DateTime>? selectedDates;
  final Function(DateTime)? onDaySelected;
  final DateTimeType? dateTimeType;

  const CustomDatePicker({
    Key? key,
    required this.state,
    required this.logic,
    this.selectedDates,
    this.onDaySelected,
    this.dateTimeType,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late List<DateTime> selectedDates;
  late DateTime selectedSingleDate;
  late DateTimeType dateTimeType;

  @override
  void initState() {
    selectedDates = widget.selectedDates ?? List<DateTime>.empty();
    dateTimeType = widget.dateTimeType ?? DateTimeType.single;
    selectedSingleDate = DateTime.now();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    selectedDates = widget.selectedDates ?? List<DateTime>.empty();
    return dateTimeType == DateTimeType.single
        ? _buildSingleTableCalendar()
        : _buildMultiTableCalendar();
  }

  _buildSingleTableCalendar() {
    return TableCalendar(
      currentDay: DateTime.now(),
      focusedDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime(2050),
      daysOfWeekHeight: 50.0,
      calendarFormat: CalendarFormat.month,
      dayHitTestBehavior: HitTestBehavior.translucent,
      selectedDayPredicate: (day) {
        bool result = false;
        for (var element in selectedDates) {
          var dayFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(day);
          var selectedDayFormatted =
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(element);
          if (dayFormatted == selectedDayFormatted) {
            result = true;
          }
        }

        return result;
      },
      enabledDayPredicate: (day) {
        bool isDisabled = false;
        if (day.day == 29) {
          return true;
        }
        return isDisabled;
      },
      onDaySelected: (selectedDay, focusedDay) {
        var dayFormatted =
            DateFormat("yyyy-MM-ddTHH:mm:ss").format(selectedDay);
        var selectedDayFormatted =
            DateFormat("yyyy-MM-ddTHH:mm:ss").format(selectedSingleDate);
        if (dayFormatted == selectedDayFormatted) {
          setState(() {
            selectedSingleDate = selectedDay;
          });
        }
      },
      headerStyle: HeaderStyle(
          leftChevronVisible: true,
          rightChevronVisible: true,
          leftChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
          ]),
          rightChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_right,
              size: 30,
              color: Colors.black,
            )
          ]),
          formatButtonShowsNext: true,
          formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
            color: Color(
              0xFF00A5B9,
            ),
            border: Border.symmetric(
              horizontal: BorderSide(width: 0.2, color: Colors.black),
            ),
            shape: BoxShape.circle),
        rangeHighlightColor: Colors.transparent,
        withinRangeTextStyle: Get.textTheme.bodyLarge!,
        selectedTextStyle:
            Get.textTheme.bodyText2!.copyWith(color: Colors.white),
        todayTextStyle: Get.textTheme.headline2!.copyWith(color: Colors.white),
        withinRangeDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeEndDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeStartDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6.5),
                padding: const EdgeInsets.all(11),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(
                      0xFFDFF6F9,
                    ),
                    shape: BoxShape.circle),
                child: Text(
                  '${day.day} ',
                  style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1.5,
                color: ColorConstants.kLineDark,
              ),
            ],
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(width: 1.5, color: ColorConstants.kLineDark)),
            ),
            child: Text('${day.day} '),
          );
        },
        markerBuilder: (context, date, list) {
          if (list.isEmpty) return Container();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  height: 9,
                  decoration: BoxDecoration(
                      color: hexToColor('#00A5B9'), shape: BoxShape.circle),
                ),
              );
            },
          );
        },
        disabledBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(width: 1.5, color: ColorConstants.kLineDark)),
            ),
            child: Text(
              '${day.day}',
              style: Get.textTheme.caption!
                  .copyWith(fontSize: 13, color: ColorConstants.kGrey),
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(width: 1.5, color: ColorConstants.kLineDark)),
            ),
            child: Text(
              '${day.day}',
              style: Get.textTheme.caption!
                  .copyWith(fontSize: 12, color: ColorConstants.kGrey),
            ),
          );
        },
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Column(
            children: [
              Divider(
                  thickness: 1.5, height: 15, color: ColorConstants.kLineDark),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: ColorConstants.kGrey),
                ),
              ),
              Divider(
                  thickness: 1.5, height: 15, color: ColorConstants.kLineDark),
            ],
          );
        },
        headerTitleBuilder: (context, day) {
          final text = DateFormat.yMMMM().format(day);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Get.textTheme.headline6,
              )
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          const calendarStyle = CalendarStyle();
          final alignment = calendarStyle.cellAlignment;
          const duration = Duration(milliseconds: 250);
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                margin: const EdgeInsets.symmetric(vertical: 6.5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: hexToColor("#00A5B9")),
                alignment: alignment,
                child: Text("${day.day}", style: calendarStyle.todayTextStyle),
              ),
              Divider(thickness: 1.5, color: ColorConstants.kLineDark),
            ],
          );
        },
      ),
    );
  }

  _buildMultiTableCalendar() {
    return TableCalendar(
      currentDay: DateTime.now(),
      focusedDay: DateTime.now(),
      firstDay: DateTime.now(),
      lastDay: DateTime(2050),
      daysOfWeekHeight: 50.0,
      calendarFormat: CalendarFormat.month,
      dayHitTestBehavior: HitTestBehavior.translucent,
      selectedDayPredicate: (day) {
        bool result = false;
        for (var element in selectedDates) {
          var dayFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(day);
          var selectedDayFormatted =
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(element);
          if (dayFormatted == selectedDayFormatted) {
            result = true;
          }
        }
        return result;
      },
      enabledDayPredicate: (day) {
        return true;
      },
      onDaySelected: (selectedDay, focusedDay) {
        for (var element in selectedDates) {
          var dayFormatted =
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(selectedDay);
          var selectedDayFormatted =
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(element);
          if (dayFormatted == selectedDayFormatted) {
            widget.onDaySelected!(selectedDay);
          }
        }

        setState(() {
          selectedSingleDate = selectedDay;
        });
      },
      headerStyle: HeaderStyle(
          leftChevronVisible: true,
          rightChevronVisible: true,
          leftChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
          ]),
          rightChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_right,
              size: 30,
              color: Colors.black,
            )
          ]),
          formatButtonShowsNext: true,
          formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorConstants.mainColor),
        ),
        todayDecoration: const BoxDecoration(
            color: Color(0xFF9FA8DA), shape: BoxShape.circle),
        rangeHighlightColor: Colors.transparent,
        withinRangeTextStyle: Get.textTheme.bodyLarge!,
        selectedTextStyle:
            Get.textTheme.bodyText2!.copyWith(color: Colors.white),
        todayTextStyle: Get.textTheme.headline2!.copyWith(color: Colors.white),
        withinRangeDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeEndDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeStartDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
      ),
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          var prioritizedDate = day.extractToDateOnly();
          var selectedDate = selectedSingleDate.extractToDateOnly();
          var currentDate = DateTime.now().extractToDateOnly();
          if (prioritizedDate == selectedDate &&
              prioritizedDate != currentDate) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6.5),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorConstants.mainColor),
                  ),
                  child: Text(
                    '${day.day}',
                    style: Get.textTheme.bodyText2,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: ColorConstants.calendarBorderColor,
                ),
              ],
            );
          }
        },
        selectedBuilder: (context, day, focusedDay) {
          if (day.month != focusedDay.month) {
            //outside builder
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  width: 1,
                  color: ColorConstants.calendarBorderColor,
                )),
              ),
              child: Text(
                '${day.day}',
                style: Get.textTheme.caption!
                    .copyWith(fontSize: 12, color: ColorConstants.kGrey),
              ),
            );
          }

          //dates which have shift inside
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6.5),
                padding: const EdgeInsets.all(11),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(
                      0xFFDFF6F9,
                    ),
                    shape: BoxShape.circle),
                child: Text(
                  '${day.day} ',
                  style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1,
                color: ColorConstants.calendarBorderColor,
              ),
            ],
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: ColorConstants.calendarBorderColor)),
            ),
            child: Text('${day.day}'),
          );
        },
        markerBuilder: (context, date, list) {
          if (list.isEmpty) return Container();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  height: 9,
                  decoration: BoxDecoration(
                      color: hexToColor('#00A5B9'), shape: BoxShape.circle),
                ),
              );
            },
          );
        },
        disabledBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: ColorConstants.calendarBorderColor)),
            ),
            child: Text(
              '${day.day}',
              style: Get.textTheme.caption!
                  .copyWith(fontSize: 13, color: ColorConstants.kGrey),
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: ColorConstants.calendarBorderColor)),
            ),
            child: Text(
              '${day.day}',
              style: Get.textTheme.caption!
                  .copyWith(fontSize: 12, color: ColorConstants.kGrey),
            ),
          );
        },
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Column(
            children: [
              Divider(
                  thickness: 1.5, height: 15, color: ColorConstants.kLineDark),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: ColorConstants.kGrey),
                ),
              ),
              Divider(
                  thickness: 1.5, height: 15, color: ColorConstants.kLineDark),
            ],
          );
        },
        headerTitleBuilder: (context, day) {
          final text = DateFormat.yMMMM().format(day);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Get.textTheme.headline6,
              )
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          const calendarStyle = CalendarStyle();
          final alignment = calendarStyle.cellAlignment;
          const duration = Duration(milliseconds: 250);

          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                margin: const EdgeInsets.symmetric(vertical: 6.5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: hexToColor("#00A5B9")),
                alignment: alignment,
                child: Text("${day.day}", style: calendarStyle.todayTextStyle),
              ),
              Divider(thickness: 1, color: ColorConstants.calendarBorderColor),
            ],
          );
        },
      ),
    );
  }
}

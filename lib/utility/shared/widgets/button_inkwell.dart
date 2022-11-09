import 'package:flutter/material.dart';

class ButtonInkWell extends StatelessWidget {
  final Widget child;
  final Function() onPress;
  double? valueBorder;
  Function()? onLongPress;

  ButtonInkWell(
      {Key? key,
      required this.child,
      required this.onPress,
      this.valueBorder,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        onLongPress: onLongPress ?? () {},
        borderRadius: BorderRadius.circular(
            valueBorder == null ? 15 : valueBorder as double),
        child: Container(child: child),
      ),
    );
  }
}

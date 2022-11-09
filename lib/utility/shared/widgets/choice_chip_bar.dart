import 'package:flutter/material.dart';

class ChoiceChipBar<T> extends StatefulWidget {
  ChoiceChipBar({
    Key? key,
    required this.choices,
    required this.initialValue,
    this.allowDeselect = false,
    required this.onChanged,
    required this.choiceText,
    this.choiceLabel,
    this.choiceAvatar,
    required this.padding,
    required this.color,
    required this.shape,
    required this.labelStyle,
    required this.selectedColor,
    required this.selectedShape,
    required this.selectedLabelStyle,
  })  : assert(choices.isNotEmpty == true),
        super(key: key);

  final List<T> choices;
  final T initialValue;
  final bool allowDeselect;
  final ValueChanged<T> onChanged;

  // A callback to generate label text for each choice. This will be ignored
  // if [choiceLabel] is not null.
  final String Function(T e) choiceText;

  // Widget builder used to create the label for each choice. This overrides
  // [choiceText]. The returned widget must not be null.
  final Widget Function(BuildContext context, T e, bool selected)? choiceLabel;

  // Widget builder used to create the avatar for each choice.
  final Widget Function(BuildContext context, T e, bool selected)? choiceAvatar;

  final EdgeInsets padding;
  final Color color;
  final OutlinedBorder shape;
  final TextStyle labelStyle;
  final Color selectedColor;
  final OutlinedBorder selectedShape;
  final TextStyle selectedLabelStyle;

  @override
  _ChoiceChipBarState<T> createState() => _ChoiceChipBarState<T>();
}

class _ChoiceChipBarState<T> extends State<ChoiceChipBar<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _value = widget.initialValue ?? widget.choices.first;
    final contentWidget = Wrap(
        spacing: 8,
        children: widget.choices.map<Widget>((e) {
          final selected = _value == e;
          return ChoiceChip(
            backgroundColor: widget.color,
            selectedColor: widget.selectedColor,
            shape: selected ? widget.selectedShape : widget.shape,
            avatar: widget.choiceAvatar?.call(context, e, selected),
            label: widget.choiceLabel == null
                ? Text(
                    widget.choiceText == null ? '$e' : widget.choiceText(e),
                    style: selected
                        ? widget.selectedLabelStyle
                        : widget.labelStyle,
                  )
                : widget.choiceLabel!(context, e, selected),
            selected: selected,
            onSelected: (bool on) {
              if (!on && !widget.allowDeselect) {
                return;
              }
              // Can we, rather than calling setState, rebuild only the
              // the widgets which we move the selection from and to?
              setState(() {
                _value = (on ? e : null)!;
                widget.onChanged.call(_value);
              });
            },
          );
        }).toList(growable: false));
    final paddedContent = widget.padding != null
        ? Padding(
            padding: widget.padding,
            child: contentWidget,
          )
        : contentWidget;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: paddedContent,
    );
  }
}

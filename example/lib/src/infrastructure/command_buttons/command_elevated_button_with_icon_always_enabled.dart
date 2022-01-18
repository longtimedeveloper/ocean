import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandElevatedButtonWithIconAlwaysEnabled extends StatelessWidget {
  const CommandElevatedButtonWithIconAlwaysEnabled({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.icon,
    required this.labelText,
    this.style,
    this.labelFontSize,
    this.lableColor,
  }) : super(key: key);

  final CommandAlwaysEnabled command;
  final Widget icon;
  final double? labelFontSize;
  final String labelText;
  final Color? lableColor;
  final GlobalKey<FormState> parentFormKey;
  final ButtonStyle? style;

  void executeOnPressed() {
    parentFormKey.currentState?.save();
    command.execute();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      style: style,
      label: Text(
        labelText,
        style: TextStyle(fontSize: labelFontSize, color: lableColor),
      ),
      onPressed: executeOnPressed,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandElevatedButtonWithIcon extends StatelessWidget {
  const CommandElevatedButtonWithIcon({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.icon,
    required this.labelText,
    this.buttonKey,
    this.style,
    this.labelFontSize,
    this.labelColor,
    this.labelDisabledColor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  final bool autofocus;
  final Key? buttonKey;
  final Command command;
  final FocusNode? focusNode;
  final Widget icon;
  final Color? labelColor;
  final Color? labelDisabledColor;
  final double? labelFontSize;
  final String labelText;
  final GlobalKey<FormState> parentFormKey;
  final ButtonStyle? style;

  void executeOnPressed() {
    parentFormKey.currentState?.validate();
    parentFormKey.currentState?.save();
    if (command.canExecute) {
      command.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: command.canExecuteNotifier,
      builder: (context, __, _) {
        return ElevatedButton.icon(
          key: buttonKey,
          focusNode: focusNode,
          autofocus: autofocus,
          icon: icon,
          style: style,
          label: Text(
            labelText,
            style: TextStyle(
              fontSize: labelFontSize,
              color: command.canExecute ? labelColor : labelDisabledColor,
            ),
          ),
          onPressed: command.canExecute ? executeOnPressed : null,
        );
      },
    );
  }
}

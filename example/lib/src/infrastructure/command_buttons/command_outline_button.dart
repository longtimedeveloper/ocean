import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandOutlineButton extends StatelessWidget {
  const CommandOutlineButton({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.buttonText,
    this.fontSize,
    this.buttonTextColor,
    this.buttonTextDisabledColor,
    this.buttonKey,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  final bool autofocus;
  final Key? buttonKey;
  final String buttonText;
  final Color? buttonTextColor;
  final Color? buttonTextDisabledColor;
  final Clip clipBehavior;
  final Command command;
  final FocusNode? focusNode;
  final double? fontSize;
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
        return OutlinedButton(
          key: buttonKey,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: fontSize,
              color: command.canExecute ? buttonTextColor : buttonTextDisabledColor,
            ),
          ),
          onPressed: command.canExecute ? executeOnPressed : null,
        );
      },
    );
  }
}

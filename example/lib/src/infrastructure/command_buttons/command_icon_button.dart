import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandIconButton extends StatelessWidget {
  const CommandIconButton({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.icon,
    required this.iconSize,
    required this.shape,
    this.buttonKey,
    this.iconColor,
    this.iconDisabledColor,
    this.backgroundColor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  final bool autofocus;
  final Color? backgroundColor;
  final Key? buttonKey;
  final Command command;
  final FocusNode? focusNode;
  final Widget icon;
  final Color? iconColor;
  final Color? iconDisabledColor;
  final double iconSize;
  final GlobalKey<FormState> parentFormKey;
  final ShapeBorder shape;

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
        return Ink(
          decoration: ShapeDecoration(shape: shape, color: backgroundColor),
          child: IconButton(
            key: buttonKey,
            color: command.canExecute ? iconColor : iconDisabledColor,
            icon: icon,
            iconSize: iconSize,
            focusNode: focusNode,
            autofocus: autofocus,
            onPressed: command.canExecute ? executeOnPressed : null,
          ),
        );
      },
    );
  }
}

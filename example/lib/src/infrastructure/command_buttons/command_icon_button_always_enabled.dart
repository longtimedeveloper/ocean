import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandIconButtonAlwaysEnabled extends StatelessWidget {
  const CommandIconButtonAlwaysEnabled({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.icon,
    required this.iconSize,
    required this.shape,
    this.iconColor,
    this.backgroundColor,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  final bool autofocus;
  final Color? backgroundColor;
  final CommandAlwaysEnabled command;
  final FocusNode? focusNode;
  final Widget icon;
  final Color? iconColor;
  final double iconSize;
  final GlobalKey<FormState> parentFormKey;
  final ShapeBorder shape;

  void executeOnPressed() {
    parentFormKey.currentState?.save();
    command.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(shape: shape, color: backgroundColor),
      child: IconButton(
        color: iconColor,
        icon: icon,
        iconSize: iconSize,
        focusNode: focusNode,
        autofocus: autofocus,
        onPressed: executeOnPressed,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ocean/ocean.dart';

class CommandTextButtonAlwaysEnabled extends StatelessWidget {
  const CommandTextButtonAlwaysEnabled({
    Key? key,
    required this.parentFormKey,
    required this.command,
    required this.buttonText,
    this.fontSize,
    this.buttonTextColor,
    this.buttonKey,
  }) : super(key: key);

  final Key? buttonKey;
  final String buttonText;
  final Color? buttonTextColor;
  final CommandAlwaysEnabled command;
  final double? fontSize;
  final GlobalKey<FormState> parentFormKey;

  void executeOnPressed() {
    parentFormKey.currentState?.save();
    command.execute();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: buttonKey,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: fontSize, color: buttonTextColor),
      ),
      onPressed: executeOnPressed,
    );
  }
}

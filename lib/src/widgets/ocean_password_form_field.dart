import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

/// CRITICAL SECURITY ALERT:  NEVER use this widget on a public facing password field, such as a login screen password field.
/// Doing this exposes your internal password requirements. DO NOT DO THIS!
/// Instead, use an OceanTextFormField with the max length set to 25 or more.  Using 25+ permits the TextField to limit the number of characters without exposing your real internal length rules to the bad guys.
/// Obviously, use this for the user registration screen, probably the only place you'll ever use it.
class OceanPasswordFormField extends StatefulWidget {
  const OceanPasswordFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    required this.goldStandardForPasswordLength,
    required this.allowedSpecialCharacters,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.constraints,
    this.showPasswordHideShowButton = true,
    this.lowerCaseCharactersAllowed = LowerCaseCharacter.yes,
    this.upperCaseCharactersAllowed = UpperCaseCharacter.yes,
    this.digitCharactersAllowed = DigitCharacter.yes,
    this.specialCharactersAllowed = SpecialCharacter.yes,
    this.passwordFieldKeyValueString,
    this.conformPasswordFieldKeyValueString,
    this.autofocus = false,
  }) : super(
          key: key,
        );

  final String allowedSpecialCharacters;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  final BusinessObjectBase businessObjectBase;
  final String? conformPasswordFieldKeyValueString;
  final BoxConstraints? constraints;
  final DigitCharacter digitCharactersAllowed;
  final int goldStandardForPasswordLength;
  final LowerCaseCharacter lowerCaseCharactersAllowed;
  final String? passwordFieldKeyValueString;
  final String Function() propertyGetter;
  final String propertyName;
  final void Function(String) propertySetter;
  final bool showPasswordHideShowButton;
  final SpecialCharacter specialCharactersAllowed;
  final UpperCaseCharacter upperCaseCharactersAllowed;

  @override
  _OceanPasswordFormFieldState createState() => _OceanPasswordFormFieldState();
}

class _OceanPasswordFormFieldState extends State<OceanPasswordFormField> {
  static String passwordMatchesValidatorRuleName = 'PasswordMatchesValidator';

  final confirmController = TextEditingController();
  Key? confirmPasswordFieldKey;
  late final String confirmPasswordLabel;
  late final TextInputFormMetadataFacade<String> facade;
  late final FocusNode focusNode;
  bool isTextObscured = true;
  final passwordController = TextEditingController();
  Key? passwordFieldKey;
  Color passwordProgressBarColor = Colors.red;
  int passwordScore = 0;
  double passwordValue = 0;

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.passwordFieldKeyValueString != null && widget.passwordFieldKeyValueString!.isNotEmpty) {
      passwordFieldKey = Key(widget.passwordFieldKeyValueString!);
    }
    if (widget.conformPasswordFieldKeyValueString != null && widget.conformPasswordFieldKeyValueString!.isNotEmpty) {
      confirmPasswordFieldKey = Key(widget.conformPasswordFieldKeyValueString!);
    }

    final config = FormMetadataFacadeConfig(
      propertyName: widget.propertyName,
      businessObjectBase: widget.businessObjectBase,
      propertySetter: widget.propertySetter,
      propertyGetter: widget.propertyGetter,
    );

    // this single parameter config, replaces the original four.
    // This was done becasuse GetIt container does not support object construction with more than two parameters

    if (GetIt.instance.isRegistered<TextInputFormMetadataFacade<String>>()) {
      facade = GetIt.instance.get<TextInputFormMetadataFacade<String>>(param1: config);
    } else {
      facade = TextInputFormMetadataFacade<String>(config);
    }

    passwordController.value = TextEditingValue(text: facade.getPropertyValue());
    confirmController.value = TextEditingValue(text: facade.getPropertyValue());

    focusNode = FocusNode();
    focusNode.addListener(updateModel);
    onPasswordChanged(widget.propertyGetter());

    confirmPasswordLabel = PasswordFieldConstants.passwordConfirmLabelPrefix + ' ' + facade.propertyMetadata.labelText;
  }

  Widget? buildPasswordSuffixIcon() {
    if (widget.showPasswordHideShowButton) {
      return IconButton(
        key: const Key(PasswordFieldConstants.passwordFieldIconButtonKey),
        icon: Icon(isTextObscured ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            isTextObscured = !isTextObscured;
          });
        },
      );
    }
    return null;
  }

  InputDecoration confirmPasswordInputDecorationBuilder(BuildContext context) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      labelText: confirmPasswordLabel,
      constraints: widget.constraints,
    );
  }

  String? confirmPasswordsMatch() {
    if (passwordController.text == confirmController.text) {
      return null;
    }
    return MessageConstants.mustMatchFormat.formatString(facade.propertyMetadata.labelText, confirmPasswordLabel);
  }

  InputDecoration inputDecorationBuilder(BuildContext context) {
    var errorMaxLines = facade.propertyMetadata.errorMaxLines;
    if (isNullOrLessThan(errorMaxLines)) {
      errorMaxLines = PasswordFieldConstants.passwordFormFieldDefultErrorMaxLines;
    }

    var constraints = widget.constraints;
    constraints ??= const BoxConstraints(minHeight: 80);

    return InputDecoration(
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      labelText: facade.labelText,
      helperText: facade.helperText,
      hintText: facade.hintText,
      constraints: constraints,
      errorMaxLines: errorMaxLines,
      suffixIcon: buildPasswordSuffixIcon(),
    );
  }

  // did this because of code-coverage comment inability to be placed at the end of an if line of code
  bool isNullOrLessThan(int? errorMaxLines) =>
      errorMaxLines == null ||
      errorMaxLines < // coverage:ignore-line
          PasswordFieldConstants.passwordFormFieldMinimumErrorMaxLines; // coverage:ignore-line

  void onPasswordChanged(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        passwordValue = 0;
        passwordProgressBarColor = Colors.red;
      });
    } else {
      final result = PasswordStrength.calculate(
        value,
        widget.allowedSpecialCharacters,
        widget.goldStandardForPasswordLength,
        widget.lowerCaseCharactersAllowed,
        widget.upperCaseCharactersAllowed,
        widget.digitCharactersAllowed,
        widget.specialCharactersAllowed,
      );

      setState(() {
        passwordScore = result.passwordStrength;
        passwordValue = result.passwordStrength * .01;
        switch (result.passwordSafetyLevel) {
          case PasswordSafetyLevel.unsafe:
            passwordProgressBarColor = Colors.red;
            break;
          case PasswordSafetyLevel.low:
            passwordProgressBarColor = Colors.yellow;
            break;
          case PasswordSafetyLevel.medium:
            passwordProgressBarColor = Colors.blue;
            break;
          case PasswordSafetyLevel.high:
            passwordProgressBarColor = Colors.green;
            break;
        }
      });
    }
  }

  void updateModel() {
    if (focusNode.hasFocus == false) {
      facade.setFormatedPropertyValue(passwordController.text);
      passwordController.value = TextEditingValue(text: facade.getPropertyValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: passwordFieldKey,
          scrollPadding: const EdgeInsets.only(bottom: 200),
          autofocus: widget.autofocus,
          keyboardType: facade.keyBoardType,
          focusNode: focusNode,
          controller: passwordController,
          maxLength: facade.maximumLength,
          autovalidateMode: widget.autovalidateMode,
          obscureText: isTextObscured,
          validator: (value) {
            final errorText = facade.validateProperty(value);

            if (errorText != null) {
              passwordValue = 0;
              passwordScore = 0;
              passwordProgressBarColor = Colors.red;
            }

            final confirmErrorText = confirmPasswordsMatch();
            if (confirmErrorText != null) {
              facade.addExternalValidationRuleBrokenRule(passwordMatchesValidatorRuleName, confirmErrorText);
              if (errorText != null) {
                return errorText + '\n' + confirmErrorText;
              }
              return confirmErrorText;
            } else {
              facade.removeExternalValidationRuleBrokenRule(passwordMatchesValidatorRuleName);
            }

            return errorText;
          },
          onChanged: (value) {
            facade.setPropertyValue(value);
            onPasswordChanged(value);
          },
          decoration: inputDecorationBuilder(context),
          onSaved: (newValue) {
            facade.setFormatedPropertyValue(newValue);
            passwordController.value = TextEditingValue(text: facade.getPropertyValue());
          },
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            color: passwordProgressBarColor,
            value: passwordValue,
            minHeight: 10,
          ),
        ),
        Text(
          MessageConstants.passwordScoreMessageFormat.formatString(widget.goldStandardForPasswordLength, passwordScore),
          textAlign: TextAlign.center,
        ),
        TextFormField(
          key: confirmPasswordFieldKey,
          scrollPadding: const EdgeInsets.only(bottom: 200),
          keyboardType: facade.keyBoardType,
          controller: confirmController,
          maxLength: facade.maximumLength,
          autovalidateMode: AutovalidateMode.always,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          validator: (value) {
            var errorText = confirmPasswordsMatch();
            if (errorText != null) {
              facade.addExternalValidationRuleBrokenRule(passwordMatchesValidatorRuleName, errorText);
            } else {
              facade.removeExternalValidationRuleBrokenRule(passwordMatchesValidatorRuleName);
            }
            return errorText;
          },
          decoration: confirmPasswordInputDecorationBuilder(context),
        ),
      ],
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class OceanTextFormField extends StatefulWidget {
  /// Constructor for [OceanTextFormField]
  /// will be improved later
  /// [customValidationCallback] when not null, is used instead of any Validators set up for this [propertyName].
  ///
  const OceanTextFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.customValidationCallback,
    this.constraints,
    this.obscureText = false,
    this.showHideShowTextButton = false,
    this.autofocus = false,
    this.readonly = false,
    this.enabled,
    this.isDense = false,
    this.contentPadding,
  }) : super(key: key);

  /// [customValidationCallback] when not null, is used instead of any Validators set up for this [propertyName].
  final String? Function(String, dynamic)? customValidationCallback;

  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  final BusinessObjectBase businessObjectBase;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final bool isDense;
  final bool obscureText;
  final String Function() propertyGetter;
  final String propertyName;
  final void Function(String) propertySetter;
  final bool readonly;
  final bool showHideShowTextButton;

  @override
  _OceanTextFormFieldState createState() => _OceanTextFormFieldState();
}

class _OceanTextFormFieldState extends State<OceanTextFormField> {
  final controller = TextEditingController();
  late final TextInputFormMetadataFacade<String> facade;
  bool isTextObscured = false;
  late final FocusNode textFormFieldFocusNode;

  @override
  void dispose() {
    super.dispose();
    textFormFieldFocusNode.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    isTextObscured = widget.obscureText;
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
    controller.value = TextEditingValue(text: facade.getPropertyValue());
    textFormFieldFocusNode = FocusNode();
    textFormFieldFocusNode.addListener(updateModel);

    super.initState();
  }

  Widget? buildPasswordSuffixIcon() {
    if (widget.showHideShowTextButton) {
      return IconButton(
        key: const Key(OceanPasswordFieldConstants.passwordFieldIconButtonKey),
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

  InputDecoration inputDecorationBuilder(BuildContext context) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      labelText: facade.labelText,
      helperText: facade.helperText,
      hintText: facade.hintText,
      constraints: widget.constraints,
      errorMaxLines: facade.errorMaxLines,
      suffixIcon: buildPasswordSuffixIcon(),
      isDense: widget.isDense,
      contentPadding: widget.contentPadding,
    );
  }

  void updateModel() {
    if (textFormFieldFocusNode.hasFocus == false) {
      facade.setFormatedPropertyValue(controller.text);
      controller.value = TextEditingValue(text: facade.getPropertyValue());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      keyboardType: facade.keyBoardType,
      focusNode: textFormFieldFocusNode,
      controller: controller,
      maxLength: facade.maximumLength,
      readOnly: widget.readonly,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      obscureText: isTextObscured,
      autocorrect: facade.enableAutoCorrect,
      enableSuggestions: facade.enableSuggestions,
      validator: (value) {
        if (widget.customValidationCallback != null) {
          return widget.customValidationCallback!(facade.propertyName, value);
        }
        return facade.validateProperty(value);
      },
      onChanged: (value) {
        facade.setPropertyValue(value);
      },
      onSaved: (newValue) {
        facade.setFormatedPropertyValue(newValue);
        controller.value = TextEditingValue(text: facade.getPropertyValue());
      },
      decoration: inputDecorationBuilder(context),
    );
  }
}

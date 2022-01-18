import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class OceanCheckboxFormField extends StatefulWidget {
  const OceanCheckboxFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.secondary,
    this.subtitle,
    this.title,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.activeColor,
    this.checkColor,
    this.contentPadding,
    this.customValidationCallback,
  }) : super(key: key);

  final String? Function(String, dynamic)? customValidationCallback;
  final Color? activeColor;
  final AutovalidateMode autovalidateMode;
  final BusinessObjectBase businessObjectBase;
  final Color? checkColor;
  final EdgeInsetsGeometry? contentPadding;
  final ListTileControlAffinity controlAffinity;
  final bool Function() propertyGetter;
  final String propertyName;
  final void Function(bool) propertySetter;
  final Widget? secondary;
  final Widget? subtitle;
  final Widget? title;

  @override
  _OceanCheckboxFormFieldState createState() => _OceanCheckboxFormFieldState();
}

class _OceanCheckboxFormFieldState extends State<OceanCheckboxFormField> {
  late final CheckboxFormMetadataFacade<bool> facade;

  @override
  void initState() {
    final config = FormMetadataFacadeConfig<bool>(
      propertyName: widget.propertyName,
      businessObjectBase: widget.businessObjectBase,
      propertySetter: widget.propertySetter,
      propertyGetter: widget.propertyGetter,
    );

    // this single parameter config, replaces the original four.
    // This was done becasuse GetIt container does not support object construction with more than two parameters

    if (GetIt.instance.isRegistered<CheckboxFormMetadataFacade<bool>>()) {
      facade = GetIt.instance.get<CheckboxFormMetadataFacade<bool>>(param1: config);
    } else {
      facade = CheckboxFormMetadataFacade<bool>(config);
    }

    super.initState();
  }

  Widget? buildSubtitle(BuildContext context) {
    String? errorText;
    if (widget.customValidationCallback != null) {
      errorText = widget.customValidationCallback!(facade.propertyName, facade.getPropertyValue());
    }
    errorText = facade.validateProperty(facade.getPropertyValue());

    if (errorText != null && errorText.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          errorText,
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
      );
    }
    if (widget.subtitle != null) {
      return widget.subtitle;
    }
    if (errorText == null && facade.subtitleText != null && facade.subtitleText!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          facade.subtitleText!,
        ),
      );
    }

    return null;
  }

  Widget? buildTitle() {
    if (widget.title != null) {
      return widget.title;
    }
    if (facade.titleText != null && facade.titleText!.isNotEmpty) {
      return Text(facade.titleText!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      contentPadding: widget.contentPadding,
      controlAffinity: widget.controlAffinity,
      title: buildTitle(),
      secondary: widget.secondary,
      subtitle: buildSubtitle(context),
      onChanged: (value) {
        setState(() {
          facade.setFormatedPropertyValue(value);
        });
      },
      value: facade.getPropertyValue(),
    );
  }
}

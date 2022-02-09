import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class OceanSwitchFormField extends StatefulWidget {
  const OceanSwitchFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    this.secondary,
    this.subtitle,
    this.title,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.activeColor,
    this.activeTrackColor,
    this.activeThumbImage,
    this.titleColor,
    this.selectedTileColor,
    this.autofocus = false,
    this.contentPadding,
  }) : super(key: key);

  final Color? activeColor;
  final ImageProvider<Object>? activeThumbImage;
  final Color? activeTrackColor;
  final bool autofocus;
  final BusinessObjectBase businessObjectBase;
  final EdgeInsetsGeometry? contentPadding;
  final ListTileControlAffinity controlAffinity;
  final bool Function() propertyGetter;
  final String propertyName;
  final void Function(bool) propertySetter;
  final Widget? secondary;
  final Color? selectedTileColor;
  final Widget? subtitle;
  final Widget? title;
  final Color? titleColor;

  @override
  _OceanSwitchFormFieldState createState() => _OceanSwitchFormFieldState();
}

class _OceanSwitchFormFieldState extends State<OceanSwitchFormField> {
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
    if (facade.subtitleText != null && facade.subtitleText!.isNotEmpty) {
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
    return SwitchListTile(
      key: widget.key,
      activeColor: widget.activeColor,
      activeThumbImage: widget.activeThumbImage,
      activeTrackColor: widget.activeTrackColor,
      autofocus: widget.autofocus,
      contentPadding: widget.contentPadding,
      controlAffinity: widget.controlAffinity,
      secondary: widget.secondary,
      selectedTileColor: widget.selectedTileColor,
      subtitle: buildSubtitle(context),
      title: buildTitle(),
      tileColor: widget.titleColor,
      onChanged: (value) {
        setState(() {
          facade.setFormatedPropertyValue(value);
        });
      },
      value: facade.getPropertyValue(),
    );
  }
}

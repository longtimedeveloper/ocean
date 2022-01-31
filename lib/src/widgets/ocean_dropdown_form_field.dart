import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class OceanDropdownFormField<T> extends StatefulWidget {
  /// Constructor for [OceanDropdownFormField]
  /// will be improved later
  /// [customValidationCallback] when not null, is used instead of any Validators set up for this [propertyName].
  ///
  const OceanDropdownFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    required this.items,
    this.menuMaxHeight,
    this.dropdownColor,
    this.elevation = 8,
    this.icon,
    this.itemHeight,
    this.selectedItemBuilder,
    this.hint,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.customValidationCallback,
    this.autofocus = false,
  }) : super(key: key);

  /// [customValidationCallback] when not null, is used instead of any Validators set up for this [propertyName].
  final String? Function(String, dynamic)? customValidationCallback;

  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  final BusinessObjectBase businessObjectBase;
  final Color? dropdownColor;
  final int elevation;
  final Widget? hint;
  final Widget? icon;
  final double? itemHeight;
  final List<DropdownMenuItem<T>>? items;
  final double? menuMaxHeight;
  final T Function() propertyGetter;
  final String propertyName;
  final void Function(T) propertySetter;

  @override
  _OceanDropdownFormFieldState<T> createState() => _OceanDropdownFormFieldState<T>();
}

class _OceanDropdownFormFieldState<T> extends State<OceanDropdownFormField<T>> {
  late final DropdownFormMetadataFacade<T> facade;

  @override
  void initState() {
    final config = FormMetadataFacadeConfig<T>(
      propertyName: widget.propertyName,
      businessObjectBase: widget.businessObjectBase,
      propertySetter: widget.propertySetter,
      propertyGetter: widget.propertyGetter,
    );

    // this single parameter config, replaces the original four.
    // This was done becasuse GetIt container does not support object construction with more than two parameters

    if (GetIt.instance.isRegistered<DropdownFormMetadataFacade<T>>()) {
      facade = GetIt.instance.get<DropdownFormMetadataFacade<T>>(param1: config);
    } else {
      facade = DropdownFormMetadataFacade<T>(config);
    }

    super.initState();
  }

  T? getValue() {
    if (facade.getPropertyValue() == facade.notSelectedValue) {
      return null;
    }
    facade.getPropertyValue();
  }

  InputDecoration inputDecorationBuilder(BuildContext context) {
    return InputDecoration(
      helperText: facade.helperText,
      errorMaxLines: facade.errorMaxLines,
      labelText: facade.labelText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: (value) {
        if (widget.customValidationCallback != null) {
          return widget.customValidationCallback!(facade.propertyName, value);
        }
        return facade.validateProperty(value);
      },
      onChanged: (value) {
        facade.setFormatedPropertyValue(value);
      },
      value: getValue(),
      items: widget.items,
      decoration: inputDecorationBuilder(context),
      menuMaxHeight: widget.menuMaxHeight,
      dropdownColor: widget.dropdownColor,
      elevation: widget.elevation,
      icon: widget.icon,
      itemHeight: widget.itemHeight,
      selectedItemBuilder: widget.selectedItemBuilder,
      autovalidateMode: widget.autovalidateMode,
      autofocus: widget.autofocus,
      hint: widget.hint,
    );
  }
}

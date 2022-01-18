import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../src.dart';

class OceanSliderFormField extends StatefulWidget {
  const OceanSliderFormField({
    Key? key,
    required this.propertyName,
    required this.businessObjectBase,
    required this.propertySetter,
    required this.propertyGetter,
    this.showSliderLabelWithValue = true,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.onChangedCallback,
    this.onChangeStartCallback,
    this.onChangeEndCallback,
  }) : super(key: key);

  final Function(double)? onChangeStartCallback;
  final Function(double)? onChangeEndCallback;
  final Function(double)? onChangedCallback;
  final Color? activeColor;
  final BusinessObjectBase businessObjectBase;
  final Color? inactiveColor;
  final double Function() propertyGetter;
  final String propertyName;
  final void Function(double) propertySetter;
  final bool showSliderLabelWithValue;
  final Color? thumbColor;

  @override
  _OceanSliderFormFieldState createState() => _OceanSliderFormFieldState();
}

class _OceanSliderFormFieldState extends State<OceanSliderFormField> {
  late final SliderFormMetadataFacade<double> facade;

  @override
  void initState() {
    final config = FormMetadataFacadeConfig<double>(
      propertyName: widget.propertyName,
      businessObjectBase: widget.businessObjectBase,
      propertySetter: widget.propertySetter,
      propertyGetter: widget.propertyGetter,
    );

    // this single parameter config, replaces the original four.
    // This was done becasuse GetIt container does not support object construction with more than two parameters

    if (GetIt.instance.isRegistered<SliderFormMetadataFacade<double>>()) {
      facade = GetIt.instance.get<SliderFormMetadataFacade<double>>(param1: config);
    } else {
      facade = SliderFormMetadataFacade<double>(config);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: widget.activeColor,
      inactiveColor: widget.inactiveColor,
      thumbColor: widget.thumbColor,
      label: widget.showSliderLabelWithValue ? facade.getPropertyValue().round().toString() : null,
      min: facade.min,
      max: facade.max,
      divisions: facade.divisions,
      autofocus: facade.autoFocus,
      onChanged: (value) {
        setState(() {
          facade.setFormatedPropertyValue(value);
        });
        if (widget.onChangedCallback != null) {
          widget.onChangedCallback!.call(value);
        }
      },
      value: facade.getPropertyValue(),
      onChangeStart: widget.onChangeStartCallback,
      onChangeEnd: widget.onChangeEndCallback,
    );
  }
}

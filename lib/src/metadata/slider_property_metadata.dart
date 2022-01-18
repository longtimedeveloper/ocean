import 'metadata.dart';

class SliderPropertyMetadata extends PropertyMetadataBase {
  SliderPropertyMetadata({
    required String propertyName,
    this.min = 0,
    this.max = 1,
    this.divisions,
    autoFocus = false,
  }) : super(propertyName: propertyName, autoFocus: autoFocus);

  final int? divisions;
  final double max;
  final double min;
}

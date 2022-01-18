abstract class PropertyMetadataBase {
  const PropertyMetadataBase({
    required this.propertyName,
    this.autoFocus = false,
  });

  final bool autoFocus;
  final String propertyName;
}

class OceanException implements Exception {
  OceanException(this.message);

  final String message;

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

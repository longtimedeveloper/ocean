class OceanArgumentException implements Exception {
  OceanArgumentException(this.argumentName, this.message);

  final String argumentName;
  final String message;

  @override
  String toString() {
    return '$runtimeType: Argument: $argumentName, $message';
  }
}

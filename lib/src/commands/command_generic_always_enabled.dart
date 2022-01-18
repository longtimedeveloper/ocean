class CommandGenericAlwaysEnabled<T> {
  CommandGenericAlwaysEnabled({required void Function(T) executeMethod}) {
    _executeMethod = executeMethod;
  }

  late final void Function(T) _executeMethod;

  void execute(T value) {
    _executeMethod.call(value);
  }
}

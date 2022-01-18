class CommandAlwaysEnabled {
  CommandAlwaysEnabled({required void Function() executeMethod}) {
    _executeMethod = executeMethod;
  }

  late final void Function() _executeMethod;

  void execute() {
    _executeMethod.call();
  }
}

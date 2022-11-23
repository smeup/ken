class FunIdentifier {
  String component;
  String service;
  String function;

  FunIdentifier(this.component, this.service, this.function);

  isValid() {
    return (component.isNotEmpty || service.isNotEmpty || function.isNotEmpty)
        ? true
        : false;
  }
}

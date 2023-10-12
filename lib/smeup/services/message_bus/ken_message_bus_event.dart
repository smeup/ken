abstract class KenMessageBusEvent {
  String widgetId;

  KenMessageBusEvent({ required this.widgetId });
}

class TextFieldOnSavedEvent extends KenMessageBusEvent {
  String value;

  TextFieldOnSavedEvent({
    required super.widgetId,
    required this.value,
  });
}

class TextFieldOnChangeEvent extends KenMessageBusEvent {
  String value;

  TextFieldOnChangeEvent({
    required super.widgetId,
    required this.value,
  });
}

class TextAutocompleteOnTapSelectedEvent extends KenMessageBusEvent {
  dynamic value;

  TextAutocompleteOnTapSelectedEvent({
    required super.widgetId,
    required this.value,
  });
}

class TextAutocompleteOnTapSetStateEvent extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnTapSetStateEvent({
    required super.widgetId,
    required this.value,
  });
}
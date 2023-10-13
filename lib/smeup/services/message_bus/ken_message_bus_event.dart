import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../models/widgets/ken_input_panel_value.dart';

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

class TextAutocompleteOnChange extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnChange({
    required super.widgetId,
    required this.value,
  });
}

class TextAutocompleteOnSaved extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnSaved({
    required super.widgetId,
    required this.value,
  });
}

class ButtonOnPressedEvent extends KenMessageBusEvent {
  ButtonOnPressedEvent({required super.widgetId});
}

class InputPanelSubmittedEvent extends KenMessageBusEvent {
  List<SmeupInputPanelField>? value;

  InputPanelSubmittedEvent({required super.widgetId, this.value});
}

class SpotlightOnTapSelectedEvent extends KenMessageBusEvent {
  dynamic value;

  SpotlightOnTapSelectedEvent({
    required super.widgetId,
    required this.value,
  });
}

class SpotlightOnSubmitEvent extends KenMessageBusEvent {
  String value;

  SpotlightOnSubmitEvent({
    required super.widgetId,
    required this.value,
  });
}

class SpotlightOnTapSetStateEvent extends KenMessageBusEvent {
  String value;

  SpotlightOnTapSetStateEvent({
    required super.widgetId,
    required this.value,
  });
}

class SpotlightOnSavedEvent extends KenMessageBusEvent {
  String? value;

  SpotlightOnSavedEvent({
    required super.widgetId,
    required this.value,
  });
}

class SpotlightOnChangeEvent extends KenMessageBusEvent {
  String? value;

  SpotlightOnChangeEvent({
    required super.widgetId,
    required this.value,
  });
}

class ComboOnChangeEvent extends KenMessageBusEvent {
  String? value;

  ComboOnChangeEvent({
    required super.widgetId,
    required this.value,
  });
}

class RadioButtonOnPressedEvent extends KenMessageBusEvent {
  dynamic value;

  RadioButtonOnPressedEvent({
    required super.widgetId,
    required this.value,
  });
}

class RadioButtonSelDataEvent extends KenMessageBusEvent {
  dynamic value;

  RadioButtonSelDataEvent({
    required super.widgetId,
    required this.value,
  });
}

class KenBoxOnItemTapEvent extends KenMessageBusEvent {
  int index;
  dynamic data;
  bool showSelection;

  KenBoxOnItemTapEvent({
    required super.widgetId,
    required this.data,
    required this.index,
    required this.showSelection,
  });
}

class KenBoxOnSizeChangeEvent extends KenMessageBusEvent {
  Size size;

  KenBoxOnSizeChangeEvent({
    required super.widgetId,
    required this.size,
  });
}

class KenBoxOnDismissedEvent extends KenMessageBusEvent {
  DismissDirection direction;

  KenBoxOnDismissedEvent({
    required super.widgetId,
    required this.direction,
  });
}

class ImageListOnItemTapEvent extends KenBoxOnItemTapEvent {

  ImageListOnItemTapEvent({
    required super.widgetId,
    required super.index,
    required super.data,
    required super.showSelection,
  });
}
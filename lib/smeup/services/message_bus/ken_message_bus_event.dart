import 'package:flutter/widgets.dart';

import '../../models/widgets/ken_calendar_event_model.dart';
import '../../models/widgets/ken_input_panel_value.dart';
import '../../widgets/ken_calendar_widget.dart';
import '../../widgets/ken_timepicker.dart';

abstract class KenMessageBusEvent {
  String messageBusId;

  KenMessageBusEvent({required this.messageBusId});
}

class TextFieldOnSavedEvent extends KenMessageBusEvent {
  String value;

  TextFieldOnSavedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class TextFieldOnChangeEvent extends KenMessageBusEvent {
  String value;

  TextFieldOnChangeEvent({
    required super.messageBusId,
    required this.value,
  });
}

class TextAutocompleteOnTapSelectedEvent extends KenMessageBusEvent {
  dynamic value;

  TextAutocompleteOnTapSelectedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class TextAutocompleteOnTapSetStateEvent extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnTapSetStateEvent({
    required super.messageBusId,
    required this.value,
  });
}

class TextAutocompleteOnChange extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnChange({
    required super.messageBusId,
    required this.value,
  });
}

class TextAutocompleteOnSaved extends KenMessageBusEvent {
  String value;

  TextAutocompleteOnSaved({
    required super.messageBusId,
    required this.value,
  });
}

class ButtonOnPressedEvent extends KenMessageBusEvent {
  ButtonOnPressedEvent({required super.messageBusId});
}

class InputPanelSubmittedEvent extends KenMessageBusEvent {
  List<SmeupInputPanelField>? value;

  InputPanelSubmittedEvent({required super.messageBusId, this.value});
}

class SpotlightOnTapSelectedEvent extends KenMessageBusEvent {
  dynamic value;

  SpotlightOnTapSelectedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SpotlightOnSubmitEvent extends KenMessageBusEvent {
  String value;

  SpotlightOnSubmitEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SpotlightOnTapSetStateEvent extends KenMessageBusEvent {
  String value;

  SpotlightOnTapSetStateEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SpotlightOnSavedEvent extends KenMessageBusEvent {
  String? value;

  SpotlightOnSavedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SpotlightOnChangeEvent extends KenMessageBusEvent {
  String? value;

  SpotlightOnChangeEvent({
    required super.messageBusId,
    required this.value,
  });
}

class ComboOnChangeEvent extends KenMessageBusEvent {
  String? value;

  ComboOnChangeEvent({
    required super.messageBusId,
    required this.value,
  });
}

class RadioButtonOnPressedEvent extends KenMessageBusEvent {
  dynamic value;

  RadioButtonOnPressedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class RadioButtonSelDataEvent extends KenMessageBusEvent {
  dynamic value;

  RadioButtonSelDataEvent({
    required super.messageBusId,
    required this.value,
  });
}

class KenBoxOnListLoaded extends KenMessageBusEvent {
  KenBoxOnListLoaded({
    required super.messageBusId,
  });
}

class KenBoxOnItemTapEvent extends KenMessageBusEvent {
  int index;
  dynamic data;
  bool showSelection;

  KenBoxOnItemTapEvent({
    required super.messageBusId,
    required this.data,
    required this.index,
    required this.showSelection,
  });
}

class KenBoxOnDismissedEvent extends KenMessageBusEvent {
  DismissDirection direction;

  KenBoxOnDismissedEvent({
    required super.messageBusId,
    required this.direction,
  });
}

class SliderOnChangeRealtimeEvent extends KenMessageBusEvent {
  double value;

  SliderOnChangeRealtimeEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SliderOnChangedEvent extends KenMessageBusEvent {
  double value;

  SliderOnChangedEvent({
    required super.messageBusId,
    required this.value,
  });
}

class TimePickerOnChangeEvent extends KenMessageBusEvent {
  KenTimePickerData data;

  TimePickerOnChangeEvent({
    required super.messageBusId,
    required this.data,
  });
}

class DashboardOnTapEvent extends KenMessageBusEvent {
  String value;

  DashboardOnTapEvent({
    required super.messageBusId,
    required this.value,
  });
}

class SwitchOnChangeEvent extends KenMessageBusEvent {
  bool value;

  SwitchOnChangeEvent({
    required super.messageBusId,
    required this.value,
  });
}

class CalendarOnDaySelectedEvent extends KenMessageBusEvent {
  DateTime selectedDay;

  CalendarOnDaySelectedEvent({
    required super.messageBusId,
    required this.selectedDay,
  });
}

class CalendarOnMonthChangedEvent extends KenMessageBusEvent {
  DateTime focusedDay;

  CalendarOnMonthChangedEvent({
    required super.messageBusId,
    required this.focusedDay,
  });
}

class CalendarOnClickEvent extends KenMessageBusEvent {
  KenCalendarEventModel event;

  CalendarOnClickEvent({
    required super.messageBusId,
    required this.event,
  });
}

class CalendarUpdateEventsAndDataEvent extends KenMessageBusEvent {
  KenCalendarEventsAndData infos;

  CalendarUpdateEventsAndDataEvent({
    required super.messageBusId,
    required this.infos,
  });
}

class TreeNodeOnTapEvent extends KenMessageBusEvent {
  dynamic data;

  TreeNodeOnTapEvent({
    required super.messageBusId,
    required this.data,
  });
}

class KenScreenOnResume extends KenMessageBusEvent {
  KenScreenOnResume({
    required super.messageBusId,
  });
}

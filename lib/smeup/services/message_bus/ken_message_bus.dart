import 'dart:core';

import 'package:rxdart/rxdart.dart';

import 'ken_message_bus_event.dart';

class KenMessageBus {
  static KenMessageBus? _instance;
  final Subject<KenMessageBusEvent> _subject =
      BehaviorSubject<KenMessageBusEvent>();

  KenMessageBus._();

  static KenMessageBus get instance {
    _instance ??= KenMessageBus._();
    return _instance!;
  }

  fireEvent(KenMessageBusEvent event) {
    _subject.add(event);
  }

  Stream<T> event<T>(String widgetId) {
    return _subject.stream
      .where(
        (KenMessageBusEvent event) => event.widgetId == widgetId,
      ).whereType<T>();
  }
}

enum KenTopic {
  shiroButtonsGetChildren,
  shiroButtonsOnClick,
  comboGetChildren,
  textfieldGetChildren,
  textfieldOnChanged,
  textfieldOnSaved,
  comboOnClientChange,
  confirmDismiss,
  shirolistboxGetChildren,
  shirolistboxOnSizeChange,
  shirolistboxOnItemTap,
  shiroImageListGetChildren,
  shiroInputPanelOnSubmit,
  shiroboxOnDismissed,
  shiroBoxGetButtons,
  shiroBoxGetColumns,
  shiroBoxGetColumnsButtons,
  shiroDashboardOnClick,
  shiroDatePickerGetChildren,
  shiroProgressBarGetChildren,
  shiroTimePickerGetChildren,
  shiroSwitchInitState,
  shiroSwitchOnClientChange,
  shiroCalendarStartFunDate,
  shiroCalendarEndFunDate,
  shiroCalendarClientOnChangeMonth,
  shiroCalendarWidgetEventClick,
  shiroSliderGetChildren,
  shiroSliderOnClientChange,
  shiroboxGetText,
  shiroDatePickerInit,
  shiroDatePickerOnPressed,
  shiroTimePickerOnPressed,
  shiroRadioButtonInit,
  shiroRadioButtonOnPressed,
  shiroRadioButtonGetChildren,
  shiroRadioButtonSelData,
  shiroSpotLightFieldViewBuilder,
  shiroSpotLightOnTapSetState,
  shiroSpotLightOnTapSelected,
  shiroSpotLightOnSubmit,
  shiroTextAutocompleteFieldViewBuilder,
  shiroTextAutocompleteOnTapSetState,
  shiroTextAutocompleteOnTapSelected,
  shiroBoxConfirmDismiss,
  shiroBoxGetImage
}

enum KenMessageType {
  request,
  response,
}

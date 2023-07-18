import 'package:rxdart/rxdart.dart';

import '../models/KenMessageBusEvent.dart';
import '../models/KenMessageBusEventData.dart';

class KenMessageBus {
  static KenMessageBus? _instance;
  Subject<KenMessageBusEvent> _subject = BehaviorSubject<KenMessageBusEvent>();

  KenMessageBus._();

  static KenMessageBus get instance {
    _instance ??= KenMessageBus._();
    return _instance!;
  }

  _publish(
      KenMessageType messageType, String id, KenTopic topic, dynamic data) {
    _subject.add(KenMessageBusEvent(
        messageType: messageType, id: id, topic: topic, data: data));
  }

  publishRequest(String id, KenTopic topic, KenMessageBusEventData data) {
    _subject.add(KenMessageBusEvent(
        messageType: KenMessageType.request, id: id, topic: topic, data: data));
  }

  publishResponse(String id, KenTopic topic, KenMessageBusEventData data) {
    _subject.add(KenMessageBusEvent(
        messageType: KenMessageType.response,
        id: id,
        topic: topic,
        data: data));
  }

  Stream<KenMessageBusEvent> _stream({String? id, KenTopic? topic}) {
    Stream<KenMessageBusEvent> stream = _subject.stream;
    if (id != null) {
      stream = stream.where(
        (KenMessageBusEvent event) => event.id == id,
      );
    }
    if (topic != null) {
      stream = stream.where(
        (KenMessageBusEvent event) => event.topic == topic,
      );
    }
    return stream;
  }

  Stream<KenMessageBusEvent> request({String? id, KenTopic? topic}) {
    return _stream(id: id, topic: topic)
        .where((event) => event.messageType == KenMessageType.request);
  }

  Stream<KenMessageBusEvent> response({String? id, KenTopic? topic}) {
    return _stream(id: id, topic: topic)
        .where((event) => event.messageType == KenMessageType.response);
  }
}

enum KenTopic {
  buttonsGetChildren,
  comboGetChildren,
  textfieldGetChildren,
  textfieldOnChanged,
  textfieldOnSaved,
  execDynamismActions,
  comboOnClientChange,
  confirmDismiss,
  kenlistboxGetChildren,
  kenlistboxOnSizeChange,
  kenlistboxOnItemTap,
  kenImageListGetChildren,
  kenInputPanelOnSubmit,
  kenboxOnDismissed,
  kenDatePickerGetChildren,
  kenProgressBarGetChildren,
  kenTimePickerGetChildren,
  kenSwitchInitState,
  kenSwitchOnClientChange,
  kenCalendarStartFunDate,
  kenCalendarEndFunDate,
  kenCalendarClientOnChangeMonth,
  kenCalendarWidgetEventClick,
  kenSliderGetChildren,
  kenSliderOnClientChange,
  kenboxGetText
}

enum KenMessageType {
  request,
  response,
}

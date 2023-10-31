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

  Stream<T> event<T>(String messageBusId) {
    return events<T>([messageBusId]);
  }

  Stream<T> events<T>(List<String> messageBusIds) {
    return _subject.stream
        .where(
          (KenMessageBusEvent event) =>
              messageBusIds.contains(event.messageBusId),
        )
        .whereType<T>();
  }
}

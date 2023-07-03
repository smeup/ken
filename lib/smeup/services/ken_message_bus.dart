import 'package:rxdart/rxdart.dart';

class KenMessageBus {

  static KenMessageBus? _instance;
  Subject<KenEvent> _subject = BehaviorSubject<KenEvent>();

  KenMessageBus._();

  static KenMessageBus get instance {
    _instance ??= KenMessageBus._();
    return _instance!;
  }

  _publish(KenMessageType messageType, String id, KenTopic topic, dynamic data) {
    _subject.add(KenEvent(messageType: messageType, id: id, topic: topic, data: data));
  }

  publishRequest(String id, KenTopic topic, dynamic data) {
    _subject.add(KenEvent(messageType: KenMessageType.request, id: id, topic: topic, data: data));
  }

  publishResponse(String id, KenTopic topic, dynamic data) {
    _subject.add(KenEvent(messageType: KenMessageType.response, id: id, topic: topic, data: data));
  }

  Stream<KenEvent> _stream({String? id, KenTopic? topic }) {
    Stream<KenEvent> stream = _subject.stream;
    if (id != null) {
      stream = stream.where(
        (KenEvent event) => event.id == id,
      );
    }
    if (topic != null) {
      stream = stream.where(
        (KenEvent event) => event.topic == topic,
      );
    }
    return stream;
  }

  Stream<KenEvent> request({String? id, KenTopic? topic }) {
    return _stream(id: id, topic: topic).where((event) => event.messageType == KenMessageType.request);
  }

  Stream<KenEvent> response({String? id, KenTopic? topic }) {
    return _stream(id: id, topic: topic).where((event) => event.messageType == KenMessageType.response);
  }
}

enum KenTopic {
  getData,
  buttonsGetButtons,
  execDynamismActions,
}

enum KenMessageType {
  request, response,
}

class KenEvent {
  KenTopic topic;
  KenMessageType messageType;
  String id;
  dynamic data;

  KenEvent({
    required this.id,
    required this.topic,
    required this.data,
    required this.messageType,
  });
}


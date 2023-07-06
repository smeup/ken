import '../services/ken_message_bus.dart';

class KenMessageBusEvent {
  KenTopic topic;
  KenMessageType messageType;
  String id;
  dynamic data;

  KenMessageBusEvent({
    required this.id,
    required this.topic,
    required this.data,
    required this.messageType,
  });
}

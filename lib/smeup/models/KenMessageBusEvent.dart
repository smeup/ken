import '../services/ken_message_bus.dart';
import 'KenMessageBusEventData.dart';

class KenMessageBusEvent {
  KenTopic topic;
  KenMessageType messageType;
  String id;
  KenMessageBusEventData data;

  KenMessageBusEvent({
    required this.id,
    required this.topic,
    required this.data,
    required this.messageType,
  });
}

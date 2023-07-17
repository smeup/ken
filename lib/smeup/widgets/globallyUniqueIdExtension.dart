import 'package:uuid/uuid.dart';

final Map<int, String> widgetUniqueIds = {};
Uuid uuid = Uuid();

extension GloballyUniqueIdExtension on Object {
  String get globallyUniqueId {
    if (!widgetUniqueIds.containsKey(hashCode)) {
      widgetUniqueIds[hashCode] = uuid.v4();
    }
    return widgetUniqueIds[hashCode]!;
  }
}
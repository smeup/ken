import 'dart:async';

import '../models/KenMessageBusEventData.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_model_callback.dart';
import '../services/ken_message_bus.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class KenDao {
  KenModel? smeupModel;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
      KenModel? instance) instanceCallBack;

  KenDao({required this.instanceCallBack});

  Future<void> getValidation() async {
    await instanceCallBack(
        ServicesCallbackType.getValidation, null, smeupModel);
  }

  dynamic getClientDataStructure() {
    var structure = instanceCallBack(
        ServicesCallbackType.getClientDataStructure, null, smeupModel);
    return structure;
  }

  Future<dynamic> getData() {
    String globallyUniqueId = uuid.v4();
    Completer<dynamic> completer = Completer();
    KenMessageBus.instance
        .response(id: globallyUniqueId, topic: KenTopic.getData)
        .take(1)
        .listen((event) {
      this.smeupModel = event.data.model;
      completer.complete(event.data.data);
    });
    // await servicesCallBack(ServicesCallbackType.getData, null, this.smeupModel);
    KenMessageBus.instance.publishRequest(
      globallyUniqueId,
      KenTopic.getData,
      KenMessageBusEventData(
        data: null,
        model: this.smeupModel,
      ),
    );
    return completer.future;
  }
}

import 'dart:async';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';

import '../services/ken_message_bus.dart';

class KenDao {
  KenModel? smeupModel;
  String? id;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
      KenModel? instance) instanceCallBack;

  KenDao({required this.instanceCallBack, this.id}) {
    KenMessageBus.instance.request(id: id, topic: KenTopic.getData).listen(
      (KenEvent event) {
        this.smeupModel = event.data as KenModel;
      },
    );
  }

  Future<void> getValidation() async {
    await instanceCallBack(
        ServicesCallbackType.getValidation, null, smeupModel);
  }

  dynamic getClientDataStructure() {
    var structure = instanceCallBack(
        ServicesCallbackType.getClientDataStructure, null, smeupModel);
    return structure;
  }

  Future<void> getData(
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          servicesCallBack) async {

    // await servicesCallBack(ServicesCallbackType.getData, null, this.smeupModel);
    KenMessageBus.instance.publishRequest(id!, KenTopic.getData, this.smeupModel);
  }
}
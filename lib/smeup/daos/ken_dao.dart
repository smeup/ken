import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao_input_panel.dart';
import 'package:ken/smeup/daos/ken_dao_qrcode_reader.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';


class KenDao {

  KenModel? smeupModel;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack;

  KenDao({required this.instanceCallBack}) {

  }

  Future<void> getValidation() async {

    if (instanceCallBack != null) {
      await instanceCallBack(ServicesCallbackType.getValidation, null, smeupModel);
    }
  }

  dynamic getClientDataStructure() {

    if (instanceCallBack != null) {
      var structure = instanceCallBack(ServicesCallbackType.getClientDataStructure, null, smeupModel);
      return structure;
    }
  }

  Future<void> getData(Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) servicesCallBack) async {

    if (servicesCallBack != null) {
      await servicesCallBack(ServicesCallbackType.getData, null , this.smeupModel);
    }
  }

}

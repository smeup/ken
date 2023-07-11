import 'package:flutter/material.dart';

import '../models/widgets/ken_input_panel_model.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_model_callback.dart';
import 'ken_dao.dart';

extension KenDaoQrCodeReader on KenDao {
  Future<void> smeupInputPanelGetData(
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? model)
          servicesCallBack,
      KenInputPanelModel model,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {
    await this.getData();
  }
}

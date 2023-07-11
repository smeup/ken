import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';


extension KenDaoQrCodeReader on KenDao {

  Future<void> smeupInputPanelGetData(
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? model) servicesCallBack,
      KenInputPanelModel model,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context) async {

    await this.getData();
  }

}
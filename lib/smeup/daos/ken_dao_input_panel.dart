import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';


extension KenDaoInputPanel on KenDao {

  Future<void> getDataQRCodeReader() async {
    if (instanceCallBack != null) {
      instanceCallBack(ServicesCallbackType.getDataQRCodeReader, null, smeupModel);
    }
  }
}

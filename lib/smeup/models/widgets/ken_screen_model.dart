// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
// import 'package:ken/smeup/services/ken_utilities.dart';
import '../fun.dart';

class KenScreenModel extends KenModel implements KenDataInterface {
  BuildContext? context;
  static const bool defaultIsDialog = false;
  static const bool defaultBackButtonVisible = true;

  bool? isDialog;
  bool? backButtonVisible;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
      KenModel? instance) instanceCallBack;

  KenScreenModel(this.context, Fun smeupFun,
      {GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      this.isDialog = defaultIsDialog,
      this.backButtonVisible = defaultBackButtonVisible,
      required this.instanceCallBack})
      : super(formKey, scaffoldKey, context,
            title: null, instanceCallBack: instanceCallBack) {
    this.smeupFun = smeupFun;
  }

  @override
  // ignore: override_on_non_overriding_member
  setData() async {
    if (instanceCallBack != null) {
      await instanceCallBack(ServicesCallbackType.setData, null, this);
    }
  }
}

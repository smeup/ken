// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../../services/ken_data_service.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../fun.dart';

class KenScreenModel extends KenModel implements KenDataInterface {
  BuildContext? context;
  static const bool defaultIsDialog = false;
  static const bool defaultBackButtonVisible = true;

  bool? isDialog;
  bool? backButtonVisible;

  KenScreenModel(this.context, Fun smeupFun,
      {GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      this.isDialog = defaultIsDialog,
      this.backButtonVisible = defaultBackButtonVisible,})
      : super(formKey, scaffoldKey, context,
            title: null) {
    this.smeupFun = smeupFun;
  }

  @override
  // ignore: override_on_non_overriding_member
  setData() async {
    if (KenDataService.isRegistered) {
      await KenDataService.dataInitializer.setData(this);
    }
  }
}

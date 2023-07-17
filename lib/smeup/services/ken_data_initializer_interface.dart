import 'package:flutter/material.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_screen_model.dart';

abstract class KenDataInitializerInterface {
  bool isFirestore(KenModel model);
  Future<void> getDataQRCodeReader(KenModel model);
  Future<void> getValidation(KenModel model);
  Future<void> setData(KenScreenModel model);
  Future<void> fromMap(Map<dynamic, dynamic> jsonMap, KenModel model);
  void defaultInstance(KenModel model);
  dynamic getClientDataStructure(KenModel model);
  Future<void> getData(KenModel model, {bool executeDecrementDataFetch = true});
  Future<void> smeupInputPanelGetData(
      KenModel model,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      {bool executeDecrementDataFetch = true});
}

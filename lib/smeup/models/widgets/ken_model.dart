import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/ken_dao.dart';
import 'package:ken/smeup/models/dynamism.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import '../fun.dart';

enum LoadType { Immediate, Delay }
enum WidgetOrientation { Vertical, Horizontal }

// abstract class SmeupModel {
class KenModel extends KenDao {

  dynamic data;
  String? type;
  String? id;
  Fun? smeupFun;
  LoadType widgetLoadType = LoadType.Immediate;
  LinkedHashMap<String, dynamic>? options;
  dynamic optionsType;
  LinkedHashMap<String, dynamic>? optionsDefault;
  String? title = '';
  String? cmp = '';
  KenModel? parent;

  late List<Dynamism> dynamisms;
  bool? showLoader = false;
  bool notificationEnabled = true;
  bool isNotified = false;
  int? serviceStatusCode = 0;
  //int refresh;
  GlobalKey<FormState>? formKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  BuildContext? context;
  Function? onReady;

  List<KenSectionModel>? smeupSectionsModels;

  bool Function(ServicesCallbackType type, Fun? smeupFun)? firestoreCallBack;

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack;

  KenModel(this.formKey, this.scaffoldKey, this.context,
      {this.title, this.id, this.type, required this.instanceCallBack, this.firestoreCallBack})
      : super(instanceCallBack: instanceCallBack) {

    this.smeupModel = this;

    if (instanceCallBack != null) {
      instanceCallBack(ServicesCallbackType.defaultInstance, null, this);
    }
  }


  KenModel.fromMap(Map<dynamic, dynamic> jsonMap,
      this.formKey,
      this.scaffoldKey,
      this.context,
      this.instanceCallBack,
      this.firestoreCallBack)
      : super(instanceCallBack: instanceCallBack) {
    this.smeupModel = this;

    if (instanceCallBack != null) {
        instanceCallBack(ServicesCallbackType.fromMap, jsonMap, this);
    }
  }

  bool isFirestore() {
    if (firestoreCallBack != null) {
      var isFirestore = firestoreCallBack!(ServicesCallbackType.isFirestore, smeupFun);

      return isFirestore;
    } else {
      return false;
    }
  }
}

import 'dart:collection';
import 'package:flutter/material.dart';
import '../../daos/ken_dao.dart';
import '../dynamism.dart';
import 'ken_model_callback.dart';
import 'ken_section_model.dart';
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

  Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
      KenModel? instance) instanceCallBack;

  KenModel(this.formKey, this.scaffoldKey, this.context,
      {this.title, this.id, this.type, required this.instanceCallBack})
      : super(instanceCallBack: instanceCallBack) {
    this.smeupModel = this;

    instanceCallBack(ServicesCallbackType.defaultInstance, null, this);
  }

  KenModel.fromMap(
    Map<dynamic, dynamic> jsonMap,
    this.formKey,
    this.scaffoldKey,
    this.context,
    this.instanceCallBack,
  ) : super(instanceCallBack: instanceCallBack) {
    this.smeupModel = this;

    instanceCallBack(ServicesCallbackType.fromMap, jsonMap, this);
  }

  bool isFirestore() {
    var isFirestore = false;
    try {
      if (smeupModel!.smeupFun!.server.length > 0) {
        var el = smeupModel!.smeupFun!.server
            .where((element) => element["key"] == "source")
            .toList();

        if (el.isEmpty) return false;
        if (el[0]["value"].toString() == "firestore") {
          return true;
        }
      }
    } catch (e) {}
    return isFirestore;
  }
}

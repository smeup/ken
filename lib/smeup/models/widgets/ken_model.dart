import 'dart:collection';
import 'package:flutter/material.dart';
import '../../daos/ken_dao.dart';
import '../../services/ken_data_service.dart';
import '../dynamism.dart';
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

  KenModel(this.formKey, this.scaffoldKey, this.context,
      {this.title, this.id, this.type}) {
    smeupModel = this;

    KenDataService.dataInitializer.defaultInstance(this);
  }

  KenModel.fromMap(
    Map<dynamic, dynamic> jsonMap,
    this.formKey,
    this.scaffoldKey,
    this.context,
  ) {
    smeupModel = this;

    KenDataService.dataInitializer.fromMap(jsonMap, this);
  }

  bool isFirestore() {
    var isFirestore = false;
    try {
      if (smeupModel!.smeupFun!.server.isNotEmpty) {
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

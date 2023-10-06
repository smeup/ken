import 'dart:collection';
import 'package:flutter/material.dart';
import '../../daos/ken_dao.dart';
import '../../services/ken_data_service.dart';
import '../../services/ken_log_service.dart';
import '../dynamism.dart';
import 'ken_section_model.dart';
import '../fun.dart';

enum LoadType { immediate, delay }

enum WidgetOrientation { vertical, horizontal }

// abstract class SmeupModel {
class KenModel extends KenDao {
  ///GRAY COLOR
  static const Color kSecondary100 = Color(0xffB9BBBD);
  static const Color kSecondary200 = Color(0xff596776);
  static const Color kSecondary300 = Color(0xff343841);

  /// NEUTRAL COLOR
  static const Color kBack100 = Color(0xff1E2128);
  static const Color kBack200 = Color(0xff15171C);

  /// PRIMARY
  static const Color kIconColor = Color(0x1C006876);
  static const Color kPrimary = Color(0xff06899b);
  static const Color kInactivePrimary = Color(0xff53b9cc);

  /// VARIANT
  static const Color kRed = Color(0xFFC14B49);
  static const Color kOrange = Color(0xFFE79821);
  static const Color kYellow = Color(0xFFCFC034);
  static const Color kGreen = Color(0xFF30AD34);

  dynamic data;
  String? type;
  String? id;
  Fun? smeupFun;
  LoadType widgetLoadType = LoadType.immediate;
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
    } catch (e) {
      KenLogService.writeDebugMessage(e.toString(), logType: KenLogType.error);
    }
    return isFirestore;
  }
}

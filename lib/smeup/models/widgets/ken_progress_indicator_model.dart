import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenProgressIndicatorModel extends KenModel implements KenDataInterface {
  static const Color defaultColor = KenModel.kPrimary;
  static const Color defaultCircularTrackColor = KenModel.kInactivePrimary;
  static const double defaultSize = 200;

  Color? color;
  Color? circularTrackColor;
  double? size;

  KenProgressIndicatorModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.color = defaultColor,
    this.circularTrackColor = defaultCircularTrackColor,
    this.size = defaultSize,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgi';
  }

  KenProgressIndicatorModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {}
}

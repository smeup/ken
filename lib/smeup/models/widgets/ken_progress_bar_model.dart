import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenProgressBarModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultColor = KenModel.kPrimary;
  static const Color defaultLinearTrackColor = KenModel.kInactivePrimary;
  static const String defaultValueField = 'value';
  static const double defaultProgressBarMinimun = 0;
  static const double defaultProgressBarMaximun = 10;
  static const double defaultBorderRadius = 4;
  static const double defaultHeight = 10;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: 30, left: 5, right: 5);

  Color? color;
  Color? linearTrackColor;
  String? valueField;
  double? progressBarMinimun;
  double? progressBarMaximun;
  double? height;
  EdgeInsetsGeometry? padding;
  double? borderRadius;

  KenProgressBarModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.color = defaultColor,
    this.linearTrackColor = defaultLinearTrackColor,
    this.height = defaultHeight,
    this.valueField = defaultValueField,
    this.padding = defaultPadding,
    this.progressBarMinimun = defaultProgressBarMinimun,
    this.progressBarMaximun = defaultProgressBarMaximun,
    this.borderRadius = defaultBorderRadius,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgb';
  }

  KenProgressBarModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault!['valueField'] ?? defaultValueField;

    progressBarMinimun = KenUtilities.getDouble(optionsDefault!['pgbMin']) ??
        defaultProgressBarMinimun;
    progressBarMaximun = KenUtilities.getDouble(optionsDefault!['pgbMax']) ??
        defaultProgressBarMaximun;

    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    linearTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['linearTrackColor']) ??
            defaultLinearTrackColor;
    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupProgressBarDao.getData(this);
        await getData();
      };
    }
  }
}

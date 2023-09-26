// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenSwitchModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultThumbColor = KenModel.kPrimary;
  static const Color defaultTrackColor = KenModel.kInactivePrimary;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = KenModel.kSecondary100;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultWidth = 400;
  static const double defaultHeight = 50;
  static const Alignment defaultAlign = Alignment.center;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? captionFontBold;
  Color? thumbColor;
  Color? trackColor;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? text;

  KenSwitchModel({
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    id,
    type,
    title = '',
    this.text = '',
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultCaptionFontColor,
    this.captionBackColor = defaultCaptionBackColor,
    this.captionFontBold = defaultCaptionFontBold,
    this.thumbColor = defaultThumbColor,
    this.trackColor = defaultTrackColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'swt';
  }

  KenSwitchModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupSwitchDao.getData(this);
        await getData();
      };
    }
  }
}

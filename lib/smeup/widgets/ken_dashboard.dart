// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

// ignore: must_be_immutable
class KenDashboard extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? captionFontSize;
  bool? captionFontBold;
  Color? captionFontColor;
  double? iconSize;
  Color? iconColor;
  Color? backgroundColor;

  double? data;
  String? unitOfMeasure = '';
  String? text = '';
  //dynamic icon;
  String? valueColName;
  String? selectLayout;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? title;
  String? id;
  String? type;
  String? forceText;
  String? forceUm;
  String? forceValue;
  String? forceIcon;
  String? numberFormat;
  IconData? iconData;

  Function? clientOnTap;

  KenDashboard(this.scaffoldKey, this.formKey, this.data,
      {id = '',
      type = 'DSH',
      this.fontColor = KenDashboardDefaults.defaultFontColor,
      this.fontSize = KenDashboardDefaults.defaultFontSize,
      this.fontBold = KenDashboardDefaults.defaultFontBold,
      this.captionFontBold = KenDashboardDefaults.defaultCaptionFontBold,
      this.captionFontSize = KenDashboardDefaults.defaultCaptionFontSize,
      this.captionFontColor = KenDashboardDefaults.defaultCaptionFontColor,
      this.iconData,
      this.iconSize = KenDashboardDefaults.defaultIconSize,
      this.iconColor = KenDashboardDefaults.defaultIconColor,
      this.backgroundColor = KenDashboardDefaults.defaultBackgroundColor,
      this.forceIcon = KenDashboardDefaults.defaultForceIcon,
      this.forceText = KenDashboardDefaults.defaultForceText,
      this.forceUm = KenDashboardDefaults.defaultForceUm,
      this.forceValue = KenDashboardDefaults.defaultForceValue,
      this.valueColName = KenDashboardDefaults.defaultValueColName,
      this.text = '',
      this.unitOfMeasure = '',
      //this.icon,
      this.selectLayout = KenDashboardDefaults.defaultSelectLayout,
      this.width = KenDashboardDefaults.defaultWidth,
      this.height = KenDashboardDefaults.defaultHeight,
      this.padding = KenDashboardDefaults.defaultPadding,
      this.numberFormat = KenDashboardDefaults.defaultNumberFormat,
      this.title = '',
      this.clientOnTap});

  @override
  Widget build(BuildContext context) {
    final iconTheme = _getIconTheme();
    final captionStyle = _getCaptionStile();
    final textStyle = _getTextStile();
    final unitOfMeasureStyle = _getUnitOfMeasureStyle();

    final dashboard = GestureDetector(
      onTap: clientOnTap!(),
      child: Container(
          height: height,
          width: width,
          padding: padding,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        iconData,
                        //SmeupIconService.getIconData(icon),
                        color: iconTheme.color,
                        size: iconTheme.size,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        _getValue(data),
                        style: textStyle,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            unitOfMeasure!,
                            style: unitOfMeasureStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (text != null)
                    Text(
                      text!,
                      style: captionStyle,
                    )
                ]),
          )),
    );

    return dashboard;
  }

  String _getValue(double? data) {
    String newValue = data.toString();
    try {
      var split = numberFormat!.split(';');
      // String integers = split[0]; not used
      String decimals = split[1];
      int? precision = int.tryParse(decimals);
      switch (precision) {
        case 0:
          newValue = data.toString();
          // KenUtilities.getInt(data).toString();
          break;
        default:
          newValue = data!.toStringAsFixed(precision!);
      }
    } catch (e) {
      // KenLogService.writeDebugMessage('Error in dashboard _getValue: $e ',
      //     logType: KenLogType.error);
    }
    return newValue;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: captionFontColor,
        fontSize: captionFontSize,
        backgroundColor: backgroundColor);

    if (captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: fontColor, fontSize: fontSize, backgroundColor: backgroundColor);

    if (fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  TextStyle _getUnitOfMeasureStyle() {
    TextStyle style = TextStyle(
        color: captionFontColor,
        fontSize: captionFontSize,
        backgroundColor: backgroundColor);

    if (fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = IconThemeData(size: iconSize, color: iconColor);

    return themeData;
  }
}

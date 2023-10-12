// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';
import 'ken_switch_widget.dart';

// ignore: must_be_immutable
class KenSwitch extends StatelessWidget {
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
  String? id;
  String? type;
  String? title;
  bool? data;
  Function? onClientChange;
  double? parentWidth;
  double? parentHeight;

  KenSwitch({
    this.id = '',
    this.type = 'FLD',
    this.captionFontSize = KenSwitchDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenSwitchDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenSwitchDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenSwitchDefaults.defaultCaptionFontBold,
    this.thumbColor = KenSwitchDefaults.defaultThumbColor,
    this.trackColor = KenSwitchDefaults.defaultTrackColor,
    this.title = '',
    this.onClientChange,
    this.data = false,
    this.text = '',
    this.width = KenSwitchDefaults.defaultWidth,
    this.height = KenSwitchDefaults.defaultHeight,
    this.padding = KenSwitchDefaults.defaultPadding,
    this.parentHeight,
    this.parentWidth,
  });

  @override
  Widget build(BuildContext context) {
    assert(data != null);
    double? switchHeight = height;
    double? switchWidth = width;
    if (parentWidth != null && parentHeight != null) {
      if (switchHeight == 0) {
        switchHeight = parentHeight;
      }
      if (switchWidth == 0) {
        switchWidth = parentWidth;
      }
    } else {
      if (switchHeight == 0) {
        switchHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
      if (switchWidth == 0) {
        switchWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    // textstyle caption

    TextStyle captionStyle = _getCaptionStile();

    return Center(
        child: Container(
      padding: padding,
      width: switchWidth,
      height: switchHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text!,
            style: captionStyle,
          ),
          KenSwitchWidget(
            thumbColor: thumbColor,
            trackColor: trackColor,
            data: data,
            id: id,
            onClientChange: (changedValue) {
              data = changedValue;
              onClientChange!(changedValue);
            },
          ),
        ],
      ),
    ));
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
      color: captionFontColor ??
          Colors.black, // Provide a default color if it's null
      fontSize:
          captionFontSize ?? 14, // Provide a default font size if it's null
      backgroundColor: captionBackColor ?? Colors.transparent,
    );

    if (captionFontBold == false) {
      // Provide a default value for fontBold if it's null
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}

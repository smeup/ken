// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';
import 'ken_switch_widget.dart';

class KenSwitch extends StatelessWidget {
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final bool? captionFontBold;
  final Color? thumbColor;
  final Color? trackColor;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final String? text;
  final String? id;
  final String? type;
  final String? title;
  final bool? data;
  final double? parentWidth;
  final double? parentHeight;

  const KenSwitch({
    super.key,
    this.id = '',
    this.type = 'FLD',
    this.captionFontSize = KenSwitchDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenSwitchDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenSwitchDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenSwitchDefaults.defaultCaptionFontBold,
    this.thumbColor = KenSwitchDefaults.defaultThumbColor,
    this.trackColor = KenSwitchDefaults.defaultTrackColor,
    this.title = '',
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

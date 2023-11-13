// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/widgets/ken_combo_item_model.dart';
import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import 'ken_combo_widget.dart';
import 'ken_line.dart';

class KenCombo extends StatelessWidget {
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final Color? backColor;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final double? iconSize;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? dropdownColor;

  final bool? underline;
  final double? innerSpace;
  final Alignment? align;
  final EdgeInsetsGeometry? padding;
  final List<KenComboItemModel>? items;
  final String? id;
  final String? type;
  final String? title;
  final String? selectedValue;
  final String? valueField;
  final String? label;
  final String? descriptionField;
  final double? width;
  final double? height;
  final bool? showBorder;
  final double? parentHeight;
  final double? parentWidth;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const KenCombo({
    super.key,
    this.fontColor = KenComboDefaults.defaultFontColor,
    this.fontSize = KenComboDefaults.defaultFontSize,
    this.fontBold = KenComboDefaults.defaultFontBold,
    this.backColor = KenComboDefaults.defaultBackColor,
    this.captionFontBold = KenComboDefaults.defaultCaptionFontBold,
    this.captionFontSize = KenComboDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenComboDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenComboDefaults.defaultCaptionBackColor,
    this.borderColor = KenComboDefaults.defaultBorderColor,
    this.borderRadius = KenComboDefaults.defaultBorderRadius,
    this.borderWidth = KenComboDefaults.defaultBorderWidth,
    this.iconSize = KenComboDefaults.defaultIconSize,
    this.iconColor = KenComboDefaults.defaultIconColor,
    this.underline = KenComboDefaults.defaultUnderline,
    this.title,
    this.id = '',
    this.type = 'CMB',
    this.selectedValue = '',
    this.dropdownColor = KenComboDefaults.defaultDropDownColor,
    this.items = const [],
    this.align = KenComboDefaults.defaultAlign,
    this.innerSpace = KenComboDefaults.defaultInnerSpace,
    this.padding = KenComboDefaults.defaultPadding,
    this.label = KenComboDefaults.defaultLabel,
    this.valueField = KenComboDefaults.defaultValueField,
    this.descriptionField = KenComboDefaults.defaultDescriptionField,
    this.width = KenComboDefaults.defaultWidth,
    this.height = KenComboDefaults.defaultHeight,
    this.showBorder = KenComboDefaults.defaultShowBorder,
    this.parentWidth,
    this.parentHeight,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    var text = label!.isEmpty
        ? Container()
        : Text(label!, textAlign: TextAlign.center, style: _getCaptionStile());

    double boxHeight = height!;
    if (boxHeight == 0) {
      if (parentHeight != null) {
        boxHeight = parentHeight!;
      } else {
        boxHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
    }

    double? boxWidth = width;
    if (boxWidth == 0) {
      if (parentWidth != null) {
        boxWidth = parentWidth;
      } else {
        boxWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    final combo = Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: padding,
          width: boxWidth,
          height: boxHeight,
          decoration: showBorder == true
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
                  border: Border.all(
                      color: borderColor ?? Colors.transparent,
                      width: borderWidth ?? 0.0),
                )
              : null,
          child: KenComboWidget(
            id: id,
            data: items,
            fontColor: fontColor,
            fontSize: fontSize,
            fontBold: fontBold,
            backColor: backColor,
            iconColor: iconColor,
            iconSize: iconSize,
            dropdownColor: dropdownColor,
            captionFontBold: captionFontBold,
            captionFontColor: captionFontColor,
            captionFontSize: captionFontSize,
            captionBackColor: captionBackColor,
            selectedValue: selectedValue,
            scaffoldKey: scaffoldKey,
          )),
    );

    var line = underline! ? const KenLine() : Container();

    Widget children;

    if (align == Alignment.centerLeft) {
      children = Padding(
        padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text,
              SizedBox(width: innerSpace),
              Expanded(child: Align(alignment: align!, child: combo)),
            ],
          ),
          line
        ]),
      );
    } else if (align == Alignment.centerRight) {
      children = Padding(
        padding: padding!,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Align(
                  alignment: align!,
                  child: combo,
                )),
                SizedBox(width: innerSpace),
                text,
              ],
            ),
            line
          ],
        ),
      );
    } else if (align == Alignment.topCenter) {
      children = SizedBox(
        height: boxHeight,
        width: boxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: text,
            ),
            SizedBox(height: innerSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: combo,
            ),
            line
          ],
        ),
      );
    } else if (align == Alignment.bottomCenter) {
      children = SizedBox(
        height: boxHeight,
        width: boxWidth,
        child: Padding(
          padding: padding!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: combo,
              ),
              SizedBox(height: innerSpace),
              Align(
                alignment: Alignment.centerLeft,
                child: text,
              ),
              line
            ],
          ),
        ),
        //color: backColor,
      );
    } else // center
    {
      children = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          combo,
          SizedBox(width: innerSpace),
          Expanded(child: text),
        ],
      );
    }

    return children;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: captionFontColor,
        fontSize: captionFontSize,
        backgroundColor: captionBackColor);

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
}

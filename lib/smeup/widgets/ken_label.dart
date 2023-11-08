// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';

class KenLabel extends StatelessWidget {
  // graphic properties
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final Color? backColor;
  final double? iconSize;
  final Color? iconColor;

  final EdgeInsetsGeometry? padding;
  final Alignment? align;
  final double width;
  final double? height;
  final List<String?>? data;
  final String? backColorColName;
  final String? fontColorColName;
  final dynamic iconCode;
  final String? title;
  final String? id;
  final String? type;
  final IconData? iconData;
  final double? parentWidth;

  const KenLabel(
    this.data, {
    this.id = '',
    this.type = 'LAB',
    this.fontSize = KenLabelDefaults.defaultFontSize,
    this.fontBold = KenLabelDefaults.defaultFontBold,
    this.fontColor = KenLabelDefaults.defaultFontColor,
    this.backColor = KenLabelDefaults.defaultBackColor,
    this.iconData,
    this.iconSize = KenLabelDefaults.defaultIconSize,
    this.iconColor = KenLabelDefaults.defaultIconColor,
    this.padding = KenLabelDefaults.defaultPadding,
    this.align = KenLabelDefaults.defaultAlign,
    this.width = KenLabelDefaults.defaultWidth,
    this.height = KenLabelDefaults.defaultHeight,
    this.backColorColName = '',
    this.iconCode,
    this.fontColorColName = '',
    this.title = '',
    this.parentWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    assert(data != null, 'Data must not be null');
    List<Widget> alignes = data!
        .map(
          (text) => Expanded(
            flex: 1,
            child: Align(
              alignment: align!,
              child: Text(
                text ?? '',
                style: _getTextStile(),
              ),
            ),
          ),
        )
        .toList();

    final col = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: alignes,
    );

    double labelHeight = height! * alignes.length * (fontSize! / 5);
    double? labelWidth = width;
    if (labelWidth == 0) {
      if (parentWidth != null) {
        labelWidth = parentWidth;
      } else {
        labelWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    if (iconCode == null) {
      return Container(
        padding: padding,
        //color: widget.backColor,
        height: labelHeight,
        width: labelWidth,
        child: col,
      );
    } else {
      final label = SizedBox(
          //color: widget.backColor,
          height: labelHeight,
          child: col);

      IconThemeData iconTheme = _getIconTheme();

      final icon = Icon(
        iconData,
        //SmeupIconService.getIconData(widget.iconCode),
        color: iconTheme.color,
        size: iconTheme.size,
      );

      Container children;
      double widgetHeight = labelHeight + iconTheme.size!;

      if (align == Alignment.centerLeft) {
        children = Container(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label,
              const Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                constraints: const BoxConstraints(
                    maxHeight: 60,
                    minWidth: 0,
                    maxWidth: double.infinity,
                    minHeight: 60),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        child: icon,
                      )
                    ]),
              ),
            ],
          ),
          //color: widget.backColor,
        );
      }
      // else if (widget.align == Alignment.centerRight) {
      //   children = Container(
      //     padding: widget.padding,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         icon,
      //         Padding(padding: EdgeInsets.fromLTRB(0, 20, 10, 0)),
      //         label,
      //       ],
      //     ),
      //     //color: widget.backColor,
      //   );
      // }
      else if (align == Alignment.centerRight) {
        children = Container(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0), child: icon),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
              label,
            ],
          ),
          //color: widget.backColor,
        );
      } else if (align == Alignment.topCenter) {
        children = Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label,
              icon,
            ],
          ),
          //color: widget.backColor,
        );
      } else if (align == Alignment.bottomCenter) {
        children = Container(
          padding: padding,
          height: widgetHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: icon),
              label,
            ],
          ),
          //color: widget.backColor,
        );
      } else // center
      {
        children = Container(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              label,
            ],
          ),
          //color: widget.backColor,
        );
      }

      return children;
    }
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: fontColor, fontSize: fontSize, backgroundColor: backColor);

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

  IconThemeData _getIconTheme() {
    IconThemeData themeData = IconThemeData(size: iconSize, color: iconColor);

    return themeData;
  }
}

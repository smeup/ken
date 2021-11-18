import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';

// ignore: must_be_immutable
class SmeupButton extends StatelessWidget {
  final int buttonIndex;
  Color backColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double elevation;
  double fontSize;
  Color fontColor;

  final double width;
  final double height;
  final MainAxisAlignment position;
  final Alignment align;
  final EdgeInsetsGeometry padding;
  final String data;
  final String valueField;
  final bool bold;
  final double iconSize;
  final int iconData;
  final bool isLink;
  bool underline;
  final IconData icon;
  final Function clientOnPressed;
  final double innerSpace;
  final bool isBusy;
  final String id;
  final String type;
  final String title;

  SmeupButton(
      {this.id = '',
      this.type = 'BTN',
      this.title = '',
      this.data = '',
      this.backColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.fontSize,
      this.fontColor,
      this.width = SmeupButtonsModel.defaultWidth,
      this.height = SmeupButtonsModel.defaultHeight,
      this.position = SmeupButtonsModel.defaultPosition,
      this.align = SmeupButtonsModel.defaultAlign,
      this.padding = SmeupButtonsModel.defaultPadding,
      this.valueField,
      this.elevation,
      this.bold = SmeupButtonsModel.defaultBold,
      this.iconData = 0,
      this.iconSize = SmeupButtonsModel.defaultIconSize,
      this.buttonIndex,
      this.icon,
      this.clientOnPressed,
      this.isBusy = false,
      this.isLink = SmeupButtonsModel.defaultIsLink,
      this.underline = SmeupButtonsModel.defaultUnderline,
      this.innerSpace = SmeupButtonsModel.defaultInnerSpace}) {
    SmeupButtonsModel.setDefaults(this);
    if (isLink) {
      underline = true;
      borderColor = backColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButtonStyle = _getButtonStyle();

    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
      padding: padding,
      child: SizedBox(
          height: height,
          width: width,
          child: isLink
              ? _getTextButton(elevatedButtonStyle)
              : _getElevatedButton(elevatedButtonStyle)),
    );
  }

  ElevatedButton _getElevatedButton(elevatedButtonStyle) {
    return ElevatedButton(
      key: Key(id),
      style: elevatedButtonStyle,
      onPressed: clientOnPressed,
      child: _getButtonChild(),
    );
  }

  TextButton _getTextButton(elevatedButtonStyle) {
    return TextButton(
      key: Key(id),
      style: elevatedButtonStyle,
      onPressed: clientOnPressed,
      child: _getButtonChild(),
    );
  }

  Widget _getButtonChild() {
    return Column(mainAxisAlignment: position, children: <Widget>[
      isBusy
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(fontColor == null
                  ? SmeupConfigurationService.defaultLoaderColor
                  : fontColor),
            )
          : () {
              final icon = iconData == 0
                  ? Container()
                  : Icon(
                      IconData(iconData, fontFamily: 'MaterialIcons'),
                      color: fontColor,
                      size: iconSize,
                    );
              var text = Align(
                  alignment: align,
                  child: Text(data,
                      textAlign: TextAlign.center, style: _getTextStile()));

              var children;

              if (align == Alignment.centerLeft) {
                children = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text,
                      SizedBox(width: innerSpace),
                      icon,
                    ],
                  ),
                  color: backColor,
                );
              } else if (align == Alignment.centerRight) {
                children = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(width: innerSpace),
                      text,
                    ],
                  ),
                  color: backColor,
                );
              } else if (align == Alignment.topCenter) {
                children = Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text,
                      SizedBox(height: innerSpace),
                      icon,
                    ],
                  ),
                  color: backColor,
                );
              } else if (align == Alignment.bottomCenter) {
                children = Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: icon),
                      text,
                    ],
                  ),
                  color: backColor,
                );
              } else // center
              {
                children = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(width: innerSpace),
                      Expanded(child: text),
                    ],
                  ),
                  color: backColor,
                );
              }

              return children;
            }()
    ]);
  }

  ButtonStyle _getButtonStyle() {
    var elevatedButtonStyle = SmeupConfigurationService.getTheme()
        .elevatedButtonTheme
        .style
        .copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(backColor),
            elevation: MaterialStateProperty.all<double>(elevation),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius))),
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(width: borderWidth, color: borderColor)));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style =
        SmeupConfigurationService.getTheme().textTheme.copyWith().button;

    if (isLink) {
      style = style.copyWith(
        decoration: TextDecoration.underline,
      );
    } else {
      style = style.copyWith(
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      );
    }

    if (fontColor != null) {
      style = style.copyWith(
          color: fontColor,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize);
    }

    return style;
  }
}

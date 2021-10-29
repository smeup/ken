import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';

class SmeupButton extends StatelessWidget {
  final int buttonIndex;
  final Color backColor;
  final Color borderColor;
  final double width;
  final double height;
  final MainAxisAlignment position;
  final Alignment align;
  final Color fontColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final String data;
  final String valueField;
  final double borderRadius;
  final double elevation;
  final bool bold;
  final double iconSize;
  final int iconData;
  final bool isLink;
  final bool underline;
  final IconData icon;
  final Function clientOnPressed;
  final double innerSpace;

  //final dynamic data;
  final bool isBusy;
  final String id;
  final String type;
  final String title;

  const SmeupButton(
      {this.id = '',
      this.type = 'BTN',
      this.title = '',
      this.data = '',
      this.backColor,
      this.borderColor,
      this.width = SmeupButtonsModel.defaultWidth,
      this.height = SmeupButtonsModel.defaultHeight,
      this.position = SmeupButtonsModel.defaultPosition,
      this.align = SmeupButtonsModel.defaultAlign,
      this.fontColor,
      this.fontSize = SmeupButtonsModel.defaultFontsize,
      this.padding = SmeupButtonsModel.defaultPadding,
      this.valueField,
      this.borderRadius = SmeupButtonsModel.defaultBorderRadius,
      this.elevation = SmeupButtonsModel.defaultElevation,
      this.bold = SmeupButtonsModel.defaultBold,
      this.iconData = 0,
      this.iconSize = SmeupButtonsModel.defaultIconSize,
      this.buttonIndex,
      this.icon,
      this.clientOnPressed,
      //this.data,
      this.isBusy = false,
      this.isLink = SmeupButtonsModel.defaultIsLink,
      this.underline = SmeupButtonsModel.defaultUnderline,
      this.innerSpace = SmeupButtonsModel.defaultInnerSpace});

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = backColor == null
        ? SmeupConfigurationService.getTheme().buttonTheme.colorScheme.onPrimary
        : backColor;

    final _borderColor = borderColor != null
        ? borderColor
        : SmeupConfigurationService.getTheme().primaryColor;

    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
      padding: padding,
      child: SizedBox(
          height: height,
          width: width,
          child: isLink
              ? _getTextButton(_backgroundColor, _borderColor)
              : _getElevatedButton(_backgroundColor, _borderColor)),
    );
  }

  ElevatedButton _getElevatedButton(backgroundColor, borderColor) {
    return ElevatedButton(
      key: Key(id),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: SmeupConfigurationService.getTheme().primaryColor,
        elevation: elevation,
        // focusColor: backgroundColor,

        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
                width: borderColor == null ? 2 : 2, color: borderColor)),
      ),
      onPressed: clientOnPressed,
      child: _getButtonChild(),
    );
  }

  TextButton _getTextButton(backgroundColor, borderColor) {
    return TextButton(
      key: Key(id),
      // style: TextButton.styleFrom(
      //   textStyle: const TextStyle(fontSize: fontsize, background: backgroundColor, color: fontColor),
      // ),
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
              //Row(children: [],)
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: underline
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontWeight:
                              bold ? FontWeight.bold : FontWeight.normal,
                          fontSize: fontSize,
                          color: fontColor == null
                              ? SmeupConfigurationService.getTheme()
                                  .primaryColor
                              : fontColor)));

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
}

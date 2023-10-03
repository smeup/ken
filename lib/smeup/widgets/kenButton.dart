// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/widgets/ken_buttons_model.dart';
import '../models/widgets/ken_section_model.dart';
import '../services/ken_utilities.dart';

// ignore: must_be_immutable
class KenButton extends StatelessWidget {
  final int? buttonIndex;
  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? iconSize;
  Color? iconColor;

  final double? width;
  final double? height;
  final MainAxisAlignment? position;
  final Alignment? align;
  final EdgeInsetsGeometry? padding;
  final String? data;
  final String? valueField;
  //final dynamic iconCode;
  final bool isLink;
  final Function? clientOnPressed;
  final double innerSpace;
  final bool? isBusy;
  final String id;
  final String? type;
  final String? title;
  final KenButtonsModel? model;
  final IconData? iconData;

  KenButton(
      {super.key,
      this.id = '',
      this.type = 'BTN',
      this.title = '',
      this.data = '',
      this.backColor = KenButtonsModel.defaultBackColor,
      this.borderColor = KenButtonsModel.defaultBorderColor,
      this.borderRadius = KenButtonsModel.defaultBorderRadius,
      this.borderWidth = KenButtonsModel.defaultBorderWidth,
      this.elevation = KenButtonsModel.defaultElevation,
      this.fontSize = KenButtonsModel.defaultFontSize,
      this.fontColor = KenButtonsModel.defaultFontColor,
      this.fontBold = KenButtonsModel.defaultFontBold,
      this.iconSize = KenButtonsModel.defaultIconSize,
      this.iconColor = KenButtonsModel.defaultIconColor,
      this.width = KenButtonsModel.defaultWidth,
      this.height = KenButtonsModel.defaultHeight,
      this.position = KenButtonsModel.defaultPosition,
      this.align = KenButtonsModel.defaultAlign,
      this.padding = KenButtonsModel.defaultPadding,
      this.valueField = KenButtonsModel.defaultValueField,
      this.buttonIndex,
      this.iconData,
      this.clientOnPressed,
      this.isBusy = false,
      this.isLink = KenButtonsModel.defaultIsLink,
      this.innerSpace = KenButtonsModel.defaultInnerSpace,
      this.model}) {
    // Gestione del button link è preferibile con una icona e testo sottolineato
    // if (isLink) {
    //   borderColor = KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
    //   fontColor = backColor;
    //   backColor = KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
    // }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButtonStyle = _getButtonStyle();

    double? buttonHeight = height;
    double? buttonWidth = width;
    if (model != null && model!.parent != null) {
      if (buttonHeight == 0) {
        buttonHeight = (model!.parent as KenSectionModel).height;
      }
      if (buttonWidth == 0) {
        buttonWidth = (model!.parent as KenSectionModel).width;
      }
    } else {
      if (buttonHeight == 0) {
        buttonHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
      if (buttonWidth == 0) {
        buttonWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0),
      padding: padding,
      child: SizedBox(
          height: buttonHeight,
          width: buttonWidth,
          child: isLink
              ? _getTextButton(elevatedButtonStyle, buttonHeight, buttonWidth)
              : _getElevatedButton(
                  elevatedButtonStyle, buttonHeight, buttonWidth)),
    );
  }

  ElevatedButton _getElevatedButton(
      elevatedButtonStyle, double? buttonHeight, double? buttonWidth) {
    return ElevatedButton(
      key: Key(id),
      style: elevatedButtonStyle,
      onPressed: clientOnPressed as void Function()?,
      child: _getButtonChildren(buttonHeight, buttonWidth),
    );
  }

  TextButton _getTextButton(
      elevatedButtonStyle, double? buttonHeight, double? buttonWidth) {
    return TextButton(
      key: Key(id),
      style: elevatedButtonStyle,
      onPressed: clientOnPressed as void Function()?,
      child: _getButtonChildren(buttonHeight, buttonWidth),
    );
  }

  Widget _getButtonChildren(double? buttonHeight, double? buttonWidth) {
    IconThemeData iconTheme = _getIconTheme();
    return Column(mainAxisAlignment: position!, children: <Widget>[
      isBusy!
          ? const CircularProgressIndicator()
          : () {
              iconData == null
                  ? Container()
                  : Icon(
                      iconData,
                      //SmeupIconService.getIconData(iconCode),
                      color: iconTheme.color,
                      size: iconTheme.size,
                    );
              var text = Align(
                  alignment: align!,
                  child: Text(data!,
                      textAlign: TextAlign.center, style: _getTextStile()));

              Container children;

              if (align == Alignment.centerLeft) {
                children = Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text,
                      if (iconData != null) SizedBox(width: innerSpace),
                      if (iconData != null)
                        Icon(
                          iconData,
                          color: iconTheme.color,
                          size: iconTheme.size,
                        ),
                    ],
                  ),
                );
              } else if (align == Alignment.centerRight) {
                children = Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconData != null)
                        Icon(
                          iconData,
                          color: iconTheme.color,
                          size: iconTheme.size,
                        ),
                      if (iconData != null) SizedBox(width: innerSpace),
                      text,
                    ],
                  ),
                );
              } else if (align == Alignment.topCenter) {
                children = Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text,
                      if (iconData != null) SizedBox(height: innerSpace),
                      if (iconData != null)
                        Icon(
                          iconData,
                          color: iconTheme.color,
                          size: iconTheme.size,
                        ),
                    ],
                  ),
                );
              } else if (align == Alignment.bottomCenter) {
                children = Container(
                  height: buttonHeight,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconData != null)
                        Expanded(
                          child: Icon(
                            iconData,
                            color: iconTheme.color,
                            size: iconTheme.size,
                          ),
                        ),
                      if (iconData != null) SizedBox(width: innerSpace),
                      text,
                    ],
                  ),
                );
              } else // center
              {
                children = Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (iconData != null)
                        Icon(
                          iconData,
                          color: iconTheme.color,
                          size: iconTheme.size,
                        ),
                      text
                    ],
                  ),
                );
              }

              return children;
            }()
    ]);
  }

  ButtonStyle _getButtonStyle() {
    var elevatedButtonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(backColor),
        elevation: MaterialStateProperty.all<double?>(elevation),
        overlayColor:
            MaterialStateProperty.all<Color?>(Colors.black.withOpacity(.2)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!))),
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(width: borderWidth!, color: borderColor!)));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(color: fontColor, fontSize: fontSize);

    if (fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    if (isLink) {
      style = style.copyWith(decoration: TextDecoration.underline);
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = IconThemeData(size: iconSize, color: iconColor);

    return themeData;
  }
}

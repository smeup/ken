import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/models/widgets/ken_buttons_model.dart';

import '../services/ken_utilities.dart';
import '../services/ken_configuration_service.dart';

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
      this.fontBold,
      this.iconSize,
      this.iconColor,
      this.width = KenButtonsModel.defaultWidth,
      this.height = KenButtonsModel.defaultHeight,
      this.position = KenButtonsModel.defaultPosition,
      this.align = KenButtonsModel.defaultAlign,
      this.padding = KenButtonsModel.defaultPadding,
      this.valueField,
      this.elevation,
      this.buttonIndex,
      this.iconData,
      this.clientOnPressed,
      this.isBusy = false,
      this.isLink = KenButtonsModel.defaultIsLink,
      this.innerSpace = KenButtonsModel.defaultInnerSpace,
      this.model}) {
    KenButtonsModel.setDefaults(this);
    if (isLink) {
      borderColor = KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
      fontColor = backColor;
      backColor = KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButtonStyle = _getButtonStyle();

    double? buttonHeight = height;
    double? buttonWidth = width;
    if (model != null && model!.parent != null) {
      if (buttonHeight == 0)
        buttonHeight = (model!.parent as KenSectionModel).height;
      if (buttonWidth == 0)
        buttonWidth = (model!.parent as KenSectionModel).width;
    } else {
      if (buttonHeight == 0)
        buttonHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (buttonWidth == 0)
        buttonWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
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
          ? CircularProgressIndicator()
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

              var children;

              if (align == Alignment.centerLeft) {
                children = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text,
                      SizedBox(width: innerSpace),
                      Icon(
                        iconData,
                        color: iconTheme.color,
                        size: iconTheme.size,
                      ),
                    ],
                  ),
                  color: backColor,
                );
              } else if (align == Alignment.centerRight) {
                children = Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        color: iconTheme.color,
                        size: iconTheme.size,
                      ),
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
                      Icon(
                        iconData,
                        color: iconTheme.color,
                        size: iconTheme.size,
                      ),
                    ],
                  ),
                  color: backColor,
                );
              } else if (align == Alignment.bottomCenter) {
                children = Container(
                  height: buttonHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Icon(
                          iconData,
                          color: iconTheme.color,
                          size: iconTheme.size,
                        ),
                      ),
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
                      Icon(
                        iconData,
                        color: iconTheme.color,
                        size: iconTheme.size,
                      ),
                      //SizedBox(width: innerSpace),
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
    var elevatedButtonStyle = KenConfigurationService.getTheme()!
        .elevatedButtonTheme
        .style!
        .copyWith(
            overlayColor: MaterialStateProperty.all(backColor),
            backgroundColor: MaterialStateProperty.all<Color?>(backColor),
            elevation: MaterialStateProperty.all<double?>(elevation),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!))),
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(width: borderWidth!, color: borderColor!)));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.button!;

    style = style.copyWith(color: fontColor, fontSize: fontSize);

    if (fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    if (isLink) {
      style = style.copyWith(decoration: TextDecoration.underline);
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: iconSize, color: iconColor);

    return themeData;
  }
}

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_buttons_model.dart';

import '../services/smeup_icon_service.dart';
import '../services/smeup_utilities.dart';

// ignore: must_be_immutable
class SmeupButton extends StatelessWidget {
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
  final dynamic iconCode;
  final bool isLink;
  final IconData? icon;
  final Function? clientOnPressed;
  final double innerSpace;
  final bool? isBusy;
  final String id;
  final String? type;
  final String? title;
  final SmeupButtonsModel? model;

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
      this.fontBold,
      this.iconSize,
      this.iconColor,
      this.width = SmeupButtonsModel.defaultWidth,
      this.height = SmeupButtonsModel.defaultHeight,
      this.position = SmeupButtonsModel.defaultPosition,
      this.align = SmeupButtonsModel.defaultAlign,
      this.padding = SmeupButtonsModel.defaultPadding,
      this.valueField,
      this.elevation,
      this.iconCode,
      this.buttonIndex,
      this.icon,
      this.clientOnPressed,
      this.isBusy = false,
      this.isLink = SmeupButtonsModel.defaultIsLink,
      this.innerSpace = SmeupButtonsModel.defaultInnerSpace,
      this.model}) {
    SmeupButtonsModel.setDefaults(this);
    if (isLink) {
      borderColor =
          SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor;
      fontColor = backColor;
      backColor = SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButtonStyle = _getButtonStyle();

    double? buttonHeight = height;
    double? buttonWidth = width;
    if (model != null && model!.parent != null) {
      if (buttonHeight == 0)
        buttonHeight = (model!.parent as SmeupSectionModel).height;
      if (buttonWidth == 0)
        buttonWidth = (model!.parent as SmeupSectionModel).width;
    } else {
      if (buttonHeight == 0)
        buttonHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      if (buttonWidth == 0)
        buttonWidth = SmeupUtilities.getDeviceInfo().safeWidth;
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
              final icon = iconCode == null
                  ? Container()
                  : Icon(
                      SmeupIconService.getIconData(iconCode),
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
                  height: buttonHeight,
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
    var elevatedButtonStyle = SmeupConfigurationService.getTheme()!
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
    TextStyle style = SmeupConfigurationService.getTheme()!.textTheme.button!;

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
    IconThemeData themeData = SmeupConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: iconSize, color: iconColor);

    return themeData;
  }
}

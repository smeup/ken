// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenButton extends StatelessWidget {
  final int? buttonIndex;
  final Color? backColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final double? iconSize;
  final Color? iconColor;

  final double? width;
  final double? height;
  final MainAxisAlignment? position;
  final Alignment? align;
  final EdgeInsetsGeometry? padding;
  final String? data;
  final String? valueField;
  //final dynamic iconCode;
  final bool isLink;
  final double innerSpace;
  final bool? isBusy;
  final String id;
  final String? type;
  final String? title;
  final IconData? iconData;
  final double? parentWidth;
  final double? parentHeight;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  KenButton({
    super.key,
    this.id = '',
    this.type = 'BTN',
    this.title = '',
    this.data = '',
    this.backColor = KenButtonsDefaults.defaultBackColor,
    this.borderColor = KenButtonsDefaults.defaultBorderColor,
    this.borderRadius = KenButtonsDefaults.defaultBorderRadius,
    this.borderWidth = KenButtonsDefaults.defaultBorderWidth,
    this.elevation = KenButtonsDefaults.defaultElevation,
    this.fontSize = KenButtonsDefaults.defaultFontSize,
    this.fontColor = KenButtonsDefaults.defaultFontColor,
    this.fontBold = KenButtonsDefaults.defaultFontBold,
    this.iconSize = KenButtonsDefaults.defaultIconSize,
    this.iconColor = KenButtonsDefaults.defaultIconColor,
    this.width = KenButtonsDefaults.defaultWidth,
    this.height = KenButtonsDefaults.defaultHeight,
    this.position = KenButtonsDefaults.defaultPosition,
    this.align = KenButtonsDefaults.defaultAlign,
    this.padding = KenButtonsDefaults.defaultPadding,
    this.valueField = KenButtonsDefaults.defaultValueField,
    this.buttonIndex,
    this.iconData,
    this.isBusy = false,
    this.isLink = KenButtonsDefaults.defaultIsLink,
    this.innerSpace = KenButtonsDefaults.defaultInnerSpace,
    this.parentWidth,
    this.parentHeight,
    this.scaffoldKey,
    this.formKey,
  }) {
    // Gestione del button link è preferibile con una icona e testo sottolineato
    // if (isLink) {
    //   borderColor = KenConfigurationManager.getTheme()!.scaffoldBackgroundColor;
    //   fontColor = backColor;
    //   backColor = KenConfigurationManager.getTheme()!.scaffoldBackgroundColor;
    // }
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButtonStyle = _getButtonStyle();

    double? buttonHeight = height;
    double? buttonWidth = width;
    if (parentWidth != null && parentHeight != null) {
      if (buttonHeight == 0) {
        buttonHeight = parentHeight;
      }
      if (buttonWidth == 0) {
        buttonWidth = parentWidth;
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
      onPressed: handleTap,
      child: _getButtonChildren(buttonHeight, buttonWidth),
    );
  }

  TextButton _getTextButton(
      elevatedButtonStyle, double? buttonHeight, double? buttonWidth) {
    return TextButton(
      key: Key(id),
      style: elevatedButtonStyle,
      onPressed: handleTap,
      child: _getButtonChildren(buttonHeight, buttonWidth),
    );
  }

  void handleTap() {
    KenMessageBus.instance.fireEvent(
      ButtonOnPressedEvent(
          messageBusId: KenUtilities.getMessageBusId(id, scaffoldKey!)),
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

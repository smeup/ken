import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
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
  final double fontsize;
  final EdgeInsetsGeometry padding;
  final String data;
  final String valueField;
  final double borderRadius;
  final double elevation;
  final bool bold;
  final double iconSize;
  final int iconData;

  final IconData icon;
  final Function clientOnPressed;

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
      this.fontsize = SmeupButtonsModel.defaultFontsize,
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
      this.isBusy = false});

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        backColor == null ? SmeupOptions.theme.buttonColor : backColor;

    final _borderColor =
        borderColor != null ? borderColor : SmeupOptions.theme.primaryColor;

    return Container(
      color: Color.fromRGBO(0, 0, 0, 0),
      padding: padding,
      child: SizedBox(
        height: height,
        width: width == 0 ? double.infinity : width,
        child: ElevatedButton(
          key: Key(id),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            onPrimary: SmeupOptions.theme.primaryColor,
            elevation: elevation,
            // focusColor: backgroundColor,

            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                    width: borderColor == null ? 2 : 2, color: _borderColor)),
          ),
          onPressed: clientOnPressed,
          child: Column(mainAxisAlignment: position, children: <Widget>[
            isBusy
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(fontColor == null
                        ? SmeupOptions.loaderColor
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
                                fontWeight:
                                    bold ? FontWeight.bold : FontWeight.normal,
                                fontSize: fontsize,
                                color: fontColor == null
                                    ? SmeupOptions.theme.primaryColor
                                    : fontColor)));

                    var widget;
                    switch (align.toString()) {
                      case 'centerLeft': // text on the left icon on the right
                        widget = Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text,
                              icon,
                            ],
                          ),
                          color: backColor,
                        );
                        break;
                      case 'centerRight': // text on the right icon on the left
                        widget = Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon,
                              text,
                            ],
                          ),
                          color: backColor,
                        );
                        break;
                      case 'topCenter': // text at the top icon at the bottom
                        widget = Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text,
                              icon,
                            ],
                          ),
                          color: backColor,
                        );
                        break;
                      case 'bottomCenter': // text at the bottom icon at the top
                        widget = Container(
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

                        break;
                      default:
                        widget = Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              icon,
                              const SizedBox(width: 5),
                              text,
                            ],
                          ),
                          color: backColor,
                        );
                        break;
                    }

                    return widget;
                  }()
          ]),
        ),
      ),
    );
  }
}

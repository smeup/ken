import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';

class SmeupButton extends StatelessWidget {
  final IconData icon;
  final Function onServerPressed;
  final Function onClientPressed;
  final SmeupButtonsModel smeupButtonsModel;
  final dynamic data;
  final bool isBusy;
  const SmeupButton(
      {String id,
      this.smeupButtonsModel,
      this.icon,
      this.onServerPressed,
      this.onClientPressed,
      this.data,
      this.isBusy = false});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = smeupButtonsModel.backColor == null
        ? SmeupOptions.theme.buttonColor
        : smeupButtonsModel.backColor;

    final borderColor = smeupButtonsModel.borderColor != null
        ? smeupButtonsModel.borderColor
        : SmeupOptions.theme.primaryColor;

    return Container(
      color: Color.fromRGBO(0, 0, 0,
          0), // SmeupOptions.theme.canvasColor, // Color.fromRGBO(250, 250, 250, 1),
      padding: EdgeInsets.all(smeupButtonsModel.padding),
      child: SizedBox(
        height: smeupButtonsModel.height,
        width: smeupButtonsModel.width == 0
            ? double.infinity
            : smeupButtonsModel.width,
        child: ElevatedButton(
          key: Key(smeupButtonsModel.id),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            onPrimary: SmeupOptions.theme.primaryColor,
            elevation: smeupButtonsModel.elevation,
            // focusColor: backgroundColor,

            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(smeupButtonsModel.borderRadius),
                side: BorderSide(
                    width: smeupButtonsModel.borderColor == null ? 2 : 2,
                    color: borderColor)),
          ),
          onPressed:
              onClientPressed != null ? onClientPressed : onServerPressed,
          child: Column(
              mainAxisAlignment: smeupButtonsModel.position,
              children: <Widget>[
                isBusy
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            smeupButtonsModel.fontColor == null
                                ? SmeupOptions.loaderColor
                                : smeupButtonsModel.fontColor),
                      )
                    : () {
                        //Row(children: [],)
                        final icon = smeupButtonsModel.iconData == 0
                            ? Container()
                            : Icon(
                                IconData(smeupButtonsModel.iconData,
                                    fontFamily: 'MaterialIcons'),
                                color: smeupButtonsModel.fontColor,
                                size: smeupButtonsModel.iconSize,
                              );
                        var text = Align(
                            alignment: smeupButtonsModel.align,
                            child: Text(smeupButtonsModel.clientData,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: smeupButtonsModel.bold
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: smeupButtonsModel.fontsize,
                                    color: smeupButtonsModel.fontColor == null
                                        ? SmeupOptions.theme.primaryColor
                                        : smeupButtonsModel.fontColor)));

                        var widget;
                        switch (smeupButtonsModel.align.toString()) {
                          case 'centerLeft': // text on the left icon on the right
                            widget = Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text,
                                  icon,
                                ],
                              ),
                              color: smeupButtonsModel.backColor,
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
                              color: smeupButtonsModel.backColor,
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
                              color: smeupButtonsModel.backColor,
                            );
                            break;
                          case 'bottomCenter': // text at the bottom icon at the top
                            widget = Container(
                              height: smeupButtonsModel.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: icon),
                                  text,
                                ],
                              ),
                              color: smeupButtonsModel.backColor,
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
                              color: smeupButtonsModel.backColor,
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

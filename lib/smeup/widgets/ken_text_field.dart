// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenTextField extends StatefulWidget {
  // graphic properties
  final Color? backColor;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;

  final bool? underline;
  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showBorder;
  final String? data;
  final bool? autoFocus;
  final String id;
  final String? type;
  final String? valueField;
  final bool showSubmit;
  final String? submitLabel;
  final Widget? submitButton;

  final TextInputType? keyboard;
  final Function? clientValidator;

  final List<TextInputFormatter>? inputFormatters;

  const KenTextField({
    super.key,
    this.id = '',
    this.type = 'FLD',
    this.backColor = KenTextFieldDefaults.defaultBackColor,
    this.fontSize = KenTextFieldDefaults.defaultFontSize,
    this.fontBold = KenTextFieldDefaults.defaultFontBold,
    this.fontColor = KenTextFieldDefaults.defaultFontColor,
    this.captionBackColor = KenTextFieldDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenTextFieldDefaults.defaultCaptionFontBold,
    this.captionFontColor = KenTextFieldDefaults.defaultCaptionFontColor,
    this.captionFontSize = KenTextFieldDefaults.defaultCaptionFontSize,
    this.borderColor = KenTextFieldDefaults.defaultBorderColor,
    this.borderRadius = KenTextFieldDefaults.defaultBorderRadius,
    this.borderWidth = KenTextFieldDefaults.defaultBorderWidth,
    this.underline = KenTextFieldDefaults.defaultUnderline,
    this.label = KenTextFieldDefaults.defaultLabel,
    this.submitLabel = KenTextFieldDefaults.defaultSubmitLabel,
    this.width = KenTextFieldDefaults.defaultWidth,
    this.height = KenTextFieldDefaults.defaultHeight,
    this.padding = KenTextFieldDefaults.defaultPadding,
    this.showBorder = KenTextFieldDefaults.defaultShowBorder,
    this.autoFocus = KenTextFieldDefaults.defaultAutoFocus,
    this.valueField = KenTextFieldDefaults.defaultValueField,
    this.showSubmit = KenTextFieldDefaults.defaultShowSubmit,
    this.data,
    this.keyboard,
    this.clientValidator, // ?
    this.inputFormatters, // ?
    this.submitButton,
  });

  @override
  KenTextFieldState createState() => KenTextFieldState();
}

class KenTextFieldState extends State<KenTextField> {
  dynamic _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();

    Widget textField;

    textField = Padding(
      padding: widget.padding!,
      child: Container(
          alignment: Alignment.centerLeft,
          decoration: widget.showBorder!
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  border: Border.all(
                      color: widget.borderColor!, width: widget.borderWidth!))
              : null,
          child: TextFormField(
            style: textStyle,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autoFocus!,
            maxLines: 1,
            initialValue: _data,
            key: Key('${widget.id}_text'),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            enableSuggestions: true,
            validator: widget.clientValidator as String? Function(String?)?,
            keyboardType: widget.keyboard,
            obscureText:
                widget.keyboard == TextInputType.visiblePassword ? true : false,
            onChanged: (value) {
              KenMessageBus.instance.fireEvent(
                TextFieldOnChangeEvent(
                  widgetId: widget.id,
                  value: value,
                ),
              );
            },
            decoration: InputDecoration(
              labelStyle: captionStyle,
              labelText: widget.label,
              // errorBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.transparent),
              // ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.underline!
                        ? widget.borderColor!
                        : Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: widget.underline!
                        ? widget.borderColor!
                        : Colors.transparent),
              ),
            ),
            onSaved: (value) {
              KenMessageBus.instance.fireEvent(
                TextFieldOnSavedEvent(
                  widgetId: widget.id,
                  value: value ?? '',
                ),
              );
            },
          )),
    );

    if (widget.showSubmit) {
      Widget column;
      if (widget.submitButton != null) {
        column = Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textField,
            const SizedBox(
              height: 5,
            ),
            widget.submitButton!,
          ],
        );
      } else {
        column = Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textField,
            const SizedBox(
              height: 5,
            ),
          ],
        );
      }

      return column;
    } else {
      return textField;
    }
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold!) {
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

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
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

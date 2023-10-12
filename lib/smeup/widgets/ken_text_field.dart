// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ken_defaults.dart';
import 'ken_button.dart';
import 'ken_buttons.dart';

class KenTextField extends StatefulWidget {
  // graphic properties
  Color? backColor;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;

  bool? underline;
  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  String? data;
  bool? autoFocus;
  String? id;
  String? type;
  String? valueField;
  bool? showSubmit;
  String? submitLabel;
  KenButtons? smeupButtons;

  TextInputType? keyboard;
  Function? clientValidator;
  Function? clientOnSave;
  Function? clientOnChange;
  Function? clientOnSubmit;

  Function? onGetChildren;
  Function? onGetSubmitButton;

  List<TextInputFormatter>? inputFormatters;

  KenTextField({
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
    this.clientOnSave,
    this.clientOnChange,
    this.clientOnSubmit,
    this.inputFormatters, // ?
    this.onGetChildren,
    this.onGetSubmitButton,
  });

  @override
  _KenTextFieldState createState() => _KenTextFieldState();
}

class _KenTextFieldState extends State<KenTextField> {
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

    if (widget.onGetChildren != null) {
      widget.onGetChildren!();
    }

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
              if (widget.clientOnChange != null) widget.clientOnChange!(value);
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
              if (widget.clientOnSave != null) widget.clientOnSave!(value);
            },
          )),
    );

    if (widget.showSubmit!) {
      KenButton? button;
      if (widget.onGetSubmitButton != null) {
        button = widget.onGetSubmitButton!();
      }

      final Widget column;
      if (button != null) {
        column = Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textField,
            const SizedBox(
              height: 5,
            ),
            button,
          ],
        );
      } else {
        column = Container();
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

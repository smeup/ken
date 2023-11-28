// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_buttons.dart';

class KenTextAutocomplete extends StatefulWidget {
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
  final Color? iconColor;
  final double? iconSize;

  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final List<Map<dynamic, dynamic>>? data;
  final bool? underline;
  final bool? autoFocus;
  final String? title;
  final String? defaultValue;
  final String? valueField;
  final String? id;
  final String? type;
  final bool? showSubmit;
  final String? submitLabel;
  final KenButtons? smeupButtons;
  final GlobalKey<ScaffoldState>? formKey;

  // other properties
  final Function? clientValidator;

  final Widget? submitButton;

  final TextInputType? keyboard;
  final List<TextInputFormatter>? inputFormatters;

  final String code;

  const KenTextAutocomplete({
    super.key,
    this.id = '',
    this.type = 'FLD',
    this.backColor = KenTextAutocompleteDefaults.defaultBackColor,
    this.fontSize = KenTextAutocompleteDefaults.defaultFontSize,
    this.fontBold = KenTextAutocompleteDefaults.defaultFontBold,
    this.fontColor = KenTextAutocompleteDefaults.defaultFontColor,
    this.captionBackColor = KenTextAutocompleteDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenTextAutocompleteDefaults.defaultFontBold,
    this.captionFontColor = KenTextAutocompleteDefaults.defaultCaptionFontColor,
    this.captionFontSize = KenTextAutocompleteDefaults.defaultCaptionFontSize,
    this.borderColor = KenTextAutocompleteDefaults.defaultBorderColor,
    this.iconColor = KenTextAutocompleteDefaults.defaultIconColor,
    this.borderRadius = KenTextAutocompleteDefaults.defaultBorderRadius,
    this.borderWidth = KenTextAutocompleteDefaults.defaultBorderWidth,
    this.label = KenTextAutocompleteDefaults.defaultLabel,
    this.submitLabel = KenTextAutocompleteDefaults.defaultSubmitLabel,
    this.width = KenTextAutocompleteDefaults.defaultWidth,
    this.height = KenTextAutocompleteDefaults.defaultHeight,
    this.padding = KenTextAutocompleteDefaults.defaultPadding,
    this.showborder = KenTextAutocompleteDefaults.defaultShowBorder,
    this.data,
    this.iconSize = KenTextAutocompleteDefaults.defaultIconSize,
    this.underline = KenTextAutocompleteDefaults.defaultUnderline,
    this.autoFocus = KenTextAutocompleteDefaults.defaultAutoFocus,
    this.showSubmit = KenTextAutocompleteDefaults.defaultShowSubmit,
    this.clientValidator,
    this.keyboard,
    this.inputFormatters,
    this.defaultValue,
    this.valueField,
    this.submitButton,
    this.code = '',
    this.title,
    this.smeupButtons,
    this.formKey,
  });

  @override
  KenTextAutocompleteState createState() => KenTextAutocompleteState();
}

class KenTextAutocompleteState extends State<KenTextAutocomplete> {
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

    String displayStringForOption(Map<dynamic, dynamic> option) =>
        option['value'];

    Widget children; // rinominerei il widget Autocomplete

    children = Container(
        // e anche qua rinominerei Autocomplete
        width: 300, // it has to be as much as the list panel at line 367
        padding: widget.padding,
        decoration: widget.showborder!
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                border: Border.all(
                    color: widget.borderColor!, width: widget.borderWidth!))
            : null,
        height: widget.height,
        child: RawAutocomplete<Map<dynamic, dynamic>>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            final String query = textEditingValue.text.toLowerCase();
            if (query.length < 3) {
              return [];
            }

            return _data!.where((Map<dynamic, dynamic> option) {
              return option['value']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          displayStringForOption: displayStringForOption,
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            if ((widget.code.isNotEmpty) && _data != null) {
              var currel = _data.firstWhere(
                (element) => element['code'].toString() == widget.code,
                //orElse: () => null as Map<String, String?>
              );
              if (currel != null) {
                textEditingController.text = currel['value'];
              }
            }

            return Container(
              padding: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  border: Border.all(
                      width: widget.borderWidth!, color: widget.borderColor!)),
              child: Row(children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0.0, left: 5, right: 5),
                    child: TextFormField(
                      style: textStyle,
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                      inputFormatters: widget.inputFormatters,
                      autofocus: widget.autoFocus!,
                      maxLines: 1,
                      key: Key('${widget.id}_text'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: true,
                      validator:
                          widget.clientValidator as String? Function(String?)?,
                      keyboardType: widget.keyboard,
                      obscureText:
                          widget.keyboard == TextInputType.visiblePassword
                              ? true
                              : false,
                      onChanged: (value) {
                        KenMessageBus.instance.fireEvent(
                          TextAutocompleteOnChange(
                            messageBusId: KenUtilities.getMessageBusId(
                                widget.id!, widget.formKey),
                            value: value,
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        isDense: false,
                        contentPadding: const EdgeInsets.only(left: 5, top: -8),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelStyle: captionStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: captionStyle,
                        labelText: widget.label,
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
                          TextAutocompleteOnSaved(
                            messageBusId: KenUtilities.getMessageBusId(
                                widget.id!, widget.formKey),
                            value: value ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  child: GestureDetector(
                    key: Key('${(widget.key as ValueKey).value}_icon_close'),
                    child: Icon(
                      Icons.close,
                      color: widget.iconColor,
                      size: widget.iconSize,
                    ),
                    onTap: () {
                      setState(() {
                        KenMessageBus.instance.fireEvent(
                          TextAutocompleteOnTapSetStateEvent(
                            messageBusId: KenUtilities.getMessageBusId(
                                widget.id!, widget.formKey),
                            value: widget.code,
                          ),
                        );
                      });
                    },
                  ),
                )
              ]),
            );
          },
          // ** Option list builder **
          // ** here we can work on the option**
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<Map<dynamic, dynamic>> onSelected,
              Iterable<Map<dynamic, dynamic>> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: .75,
                color: widget.backColor,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: .5,
                              color: Color.fromARGB(255, 246, 246, 246)))),
                  height: 225,
                  width: 300,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<dynamic, dynamic> option =
                          options.elementAt(index);
                      return GestureDetector(
                        key: Key(
                            '${(widget.key as ValueKey).value}_${index}_gesture_detector'),
                        onTap: () {
                          onSelected(option);
                          KenMessageBus.instance.fireEvent(
                            TextAutocompleteOnTapSelectedEvent(
                              messageBusId: KenUtilities.getMessageBusId(
                                  widget.id!, widget.formKey),
                              value: option,
                            ),
                          );
                        },
                        child: ListTile(
                          // leading: Text('•'), -- Eventually something that can be displayed before the text
                          title: Text(
                            option['value'],
                            style: _getTextStile(),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey[200],
                        thickness: 1,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));

    if (widget.showSubmit!) {
      final Widget column;
      if (widget.submitButton != null) {
        column = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            children,
            const SizedBox(
              height: 2,
            ),
            widget.submitButton!,
          ],
        );
      } else {
        column = Container();
      }

      return column;
    } else {
      return children;
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

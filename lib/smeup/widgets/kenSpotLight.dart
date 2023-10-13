import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_buttons.dart';

class KenSpotLight extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

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
  Color? iconColor;
  double? iconSize;

  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showborder;
  List<Map<dynamic, dynamic>>? data;
  bool? underline;
  bool? autoFocus;
  String? title;
  String? defaultValue;
  String? valueField;
  String? id;
  String? type;
  bool? showSubmit;
  String? submitLabel;
  KenButtons? smeupButtons;

  // other properties
  Function? clientValidator;

  Widget? submitButton;

  TextInputType? keyboard;
  List<TextInputFormatter>? inputFormatters;

  KenSpotLight(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'SPL',
      this.backColor = KenSpotlightDefaults.defaultBackColor,
      this.fontSize = KenSpotlightDefaults.defaultFontSize,
      this.fontBold = KenSpotlightDefaults.defaultFontBold,
      this.fontColor = KenSpotlightDefaults.defaultFontColor,
      this.captionBackColor = KenSpotlightDefaults.defaultCaptionBackColor,
      this.captionFontBold = KenSpotlightDefaults.defaultFontBold,
      this.captionFontColor = KenSpotlightDefaults.defaultCaptionFontColor,
      this.captionFontSize = KenSpotlightDefaults.defaultCaptionFontSize,
      this.borderColor = KenSpotlightDefaults.defaultBorderColor,
      this.iconColor = KenSpotlightDefaults.defaultIconColor,
      this.borderRadius = KenSpotlightDefaults.defaultBorderRadius,
      this.borderWidth = KenSpotlightDefaults.defaultBorderWidth,
      this.label = KenSpotlightDefaults.defaultLabel,
      this.submitLabel = KenSpotlightDefaults.defaultSubmitLabel,
      this.width = KenSpotlightDefaults.defaultWidth,
      this.height = KenSpotlightDefaults.defaultHeight,
      this.padding = KenSpotlightDefaults.defaultPadding,
      this.showborder = KenSpotlightDefaults.defaultShowBorder,
      this.data,
      this.iconSize = KenSpotlightDefaults.defaultIconSize,
      this.underline = KenSpotlightDefaults.defaultUnderline,
      this.autoFocus = KenSpotlightDefaults.defaultAutoFocus,
      this.showSubmit = KenSpotlightDefaults.defaultShowSubmit,
      this.clientValidator,
      this.keyboard,
      this.inputFormatters,
      this.defaultValue,
      this.valueField,
      this.submitButton,
      this.smeupButtons});

  @override
  _KenSpotLightState createState() => _KenSpotLightState();
}

class _KenSpotLightState extends State<KenSpotLight> {
  dynamic _data;

  List<Map<dynamic, dynamic>>? _options;

  @override
  void initState() {
    _data = widget.data;
    _options = _data ?? [];
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

    String _displayStringForOption(Map<dynamic, dynamic> option) =>
        option['value'];

    Widget children; // rinominerei il widget Autocomplete

    String code = "";
    dynamic currel;

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

            return _options!.where((Map<dynamic, dynamic> option) {
              return option['value']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          displayStringForOption: _displayStringForOption,
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            if (currel != null) {
              textEditingController.text = currel['value'];
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

                          // KenMessageBus.instance.publishRequest(
                          //   widget.globallyUniqueId,
                          //   KenTopic.kenSpotLightOnSubmit,
                          //   KenMessageBusEventData(
                          //       context: context,
                          //       widget: widget,
                          //       model: _model,
                          //       data: value),
                          // );
                        },
                        inputFormatters: widget.inputFormatters,
                        autofocus: widget.autoFocus!,
                        maxLines: 1,
                        key: Key('${widget.id}_text'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        validator: widget.clientValidator as String? Function(
                            String?)?,
                        keyboardType: widget.keyboard,
                        obscureText:
                            widget.keyboard == TextInputType.visiblePassword
                                ? true
                                : false,
                        onChanged: (value) {
                          KenMessageBus.instance.fireEvent(
                            SpotlightOnChangeEvent(
                              widgetId: widget.id!,
                              value: value,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          isDense: false,
                          contentPadding:
                              const EdgeInsets.only(left: 5, top: -8),
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
                        onSaved: (String? value) {
                          KenMessageBus.instance.fireEvent(
                            SpotlightOnSavedEvent(
                              widgetId: widget.id!,
                              value: value,
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: widget.iconColor,
                      size: widget.iconSize,
                    ),
                    onTap: () {
                      setState(() {
                        KenMessageBus.instance.fireEvent(
                          SpotlightOnTapSetStateEvent(
                            widgetId: widget.id!,
                            value: code,
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
                        onTap: () {
                          onSelected(option);

                          KenMessageBus.instance.fireEvent(
                            SpotlightOnTapSelectedEvent(
                              widgetId: widget.id!,
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

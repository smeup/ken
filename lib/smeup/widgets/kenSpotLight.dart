// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_spotlight_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenButtons.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenSpotLight extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenSpotLightModel? model;
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
  Function? clientOnSave;
  Function? clientOnChange;
  Function? clientOnSelected;
  Function? clientOnSubmit;

  TextInputType? keyboard;
  List<TextInputFormatter>? inputFormatters;

  KenSpotLight.withController(
    KenSpotLightModel this.model,
    this.scaffoldKey,
    this.formKey,
    this.smeupButtons,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenSpotLight(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'SPL',
    this.backColor = KenSpotLightModel.defaultBackColor,
    this.fontSize = KenSpotLightModel.defaultFontSize,
    this.fontBold = KenSpotLightModel.defaultFontBold,
    this.fontColor = KenSpotLightModel.defaultFontColor,
    this.captionBackColor = KenSpotLightModel.defaultCaptionBackColor,
    this.captionFontBold = KenSpotLightModel.defaultFontBold,
    this.captionFontColor = KenSpotLightModel.defaultCaptionFontColor,
    this.captionFontSize = KenSpotLightModel.defaultCaptionFontSize,
    this.borderColor = KenSpotLightModel.defaultBorderColor,
    this.iconColor = KenSpotLightModel.defaultIconColor,
    this.borderRadius = KenSpotLightModel.defaultBorderRadius,
    this.borderWidth = KenSpotLightModel.defaultBorderWidth,
    this.label = KenSpotLightModel.defaultLabel,
    this.submitLabel = KenSpotLightModel.defaultSubmitLabel,
    this.width = KenSpotLightModel.defaultWidth,
    this.height = KenSpotLightModel.defaultHeight,
    this.padding = KenSpotLightModel.defaultPadding,
    this.showborder = KenSpotLightModel.defaultShowBorder,
    this.data,
    this.iconSize = KenSpotLightModel.defaultIconSize,
    this.underline = KenSpotLightModel.defaultUnderline,
    this.autoFocus = KenSpotLightModel.defaultAutoFocus,
    this.showSubmit = KenSpotLightModel.defaultShowSubmit,
    this.clientValidator,
    this.clientOnSave,
    this.clientOnChange,
    this.clientOnSelected,
    this.clientOnSubmit,
    this.keyboard,
    this.inputFormatters,
    this.defaultValue,
    this.valueField,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenSpotLightModel m = model as KenSpotLightModel;
    id = m.id;
    type = m.type;
    backColor = m.backColor;
    fontSize = m.fontSize;
    fontBold = m.fontBold;
    fontColor = m.fontColor;
    captionBackColor = m.captionBackColor;
    captionFontBold = m.captionFontBold;
    captionFontColor = m.captionFontColor;
    captionFontSize = m.captionFontSize;
    borderColor = m.borderColor;
    iconColor = m.iconColor;
    borderRadius = m.borderRadius;
    borderWidth = m.borderWidth;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showBorder;
    title = m.title;
    underline = m.showUnderline;
    autoFocus = m.autoFocus;
    defaultValue = m.defaultValue;
    valueField = m.valueField;
    submitLabel = m.submitLabel;
    iconSize = m.iconSize;
    showSubmit = m.showSubmit;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenSpotLightModel m = model as KenSpotLightModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<Map<dynamic, dynamic>>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'code': element['code'].toString(),
          'value': element['value'].toString()
        });
      }
      return newList;
    } else {
      return model.data["rows"];
    }
  }

  @override
  _KenSpotLightState createState() => _KenSpotLightState();
}

class _KenSpotLightState extends State<KenSpotLight>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenSpotLightModel? _model;
  dynamic _data;

  List<Map<dynamic, dynamic>>? _options;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    _options = _data == null ? [] : _data;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget autocomplete = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return autocomplete;
  }

  /// Label's structure:
  /// define the structure ...
  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupTextAutocompleteDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
        _options = _model!.data['rows'];
      }

      setDataLoad(widget.id, true);
    }

    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();

    String _displayStringForOption(Map<dynamic, dynamic> option) =>
        option['value'];

    Widget children; // rinominerei il widget Autocomplete

    String code = "";
    dynamic currel;

    Completer<dynamic> completer = Completer();

    KenMessageBus.instance
        .response(
            id: widget.globallyUniqueId,
            topic: KenTopic.kenSpotLightFieldViewBuilder)
        .take(1)
        .listen((event) {
      if (code.isNotEmpty && _data != null) {
        currel = _data.firstWhere(
          (element) => element['code'].toString() == code,
          //orElse: () => null as Map<String, String?>
        );
      }

      completer.complete(); // resolve promise
    });

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenSpotLightFieldViewBuilder,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );

    await completer.future;

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

                          KenMessageBus.instance.publishRequest(
                            widget.globallyUniqueId,
                            KenTopic.kenSpotLightOnSubmit,
                            KenMessageBusEventData(
                                context: context,
                                widget: widget,
                                model: _model,
                                data: value),
                          );
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
                          if (widget.clientOnChange != null) {
                            widget.clientOnChange!(value);
                          }
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
                          widget.clientOnSave!(value);
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
                        KenMessageBus.instance.publishRequest(
                          widget.globallyUniqueId,
                          KenTopic.kenSpotLightOnTapSetState,
                          KenMessageBusEventData(
                              context: context,
                              widget: widget,
                              model: _model,
                              data: code),
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

                          KenMessageBus.instance.publishRequest(
                            widget.globallyUniqueId,
                            KenTopic.kenSpotLightOnTapSelected,
                            KenMessageBusEventData(
                                context: context,
                                widget: widget,
                                model: _model,
                                data: option),
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
      KenButtons? button;
      if (_model == null) {
        button = KenButtons(
          widget.scaffoldKey,
          widget.formKey,
          data: [widget.submitLabel],
          clientOnPressed: widget.clientOnSubmit,
          padding: const EdgeInsets.all(5),
        );
      } else {
        if (widget.smeupButtons != null) {
          button = widget.smeupButtons!;
        }
      }

      final Widget column;
      if (button != null) {
        column = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            children,
            const SizedBox(
              height: 2,
            ),
            button,
          ],
        );
      } else {
        column = Container();
      }

      return KenWidgetBuilderResponse(_model, column);
    } else {
      return KenWidgetBuilderResponse(_model, children);
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

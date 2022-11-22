import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_text_autocomplete_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/ken_buttons.dart';
import 'package:ken/smeup/widgets/ken_enum_callback.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:ken/smeup/widgets/ken_widget_state_mixin.dart';
import '../services/ken_theme_configuration_service.dart';
import 'ken_widget_state_interface.dart';

// ignore: must_be_immutable
class KenTextAutocomplete extends StatefulWidget with KenWidgetMixin implements KenWidgetInterface {
  KenTextAutocompleteModel? model;
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

  Future<dynamic> Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenTextAutocomplete.withController(KenTextAutocompleteModel this.model, this.scaffoldKey, this.formKey, this.smeupButtons,this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenTextAutocomplete(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.backColor,
      this.fontSize,
      this.fontBold,
      this.fontColor,
      this.captionBackColor,
      this.captionFontBold,
      this.captionFontColor,
      this.captionFontSize,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.label = KenTextAutocompleteModel.defaultLabel,
      this.submitLabel = KenTextAutocompleteModel.defaultSubmitLabel,
      this.width = KenTextAutocompleteModel.defaultWidth,
      this.height = KenTextAutocompleteModel.defaultHeight,
      this.padding = KenTextAutocompleteModel.defaultPadding,
      this.showborder = KenTextAutocompleteModel.defaultShowBorder,
      this.data,
      this.underline = KenTextAutocompleteModel.defaultUnderline,
      this.autoFocus = KenTextAutocompleteModel.defaultAutoFocus,
      this.showSubmit = KenTextAutocompleteModel.defaultShowSubmit,
      this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.clientOnSelected,
      this.clientOnSubmit,
      this.keyboard,
      this.inputFormatters,
      this.defaultValue,
      this.valueField})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenTextAutocompleteModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenTextAutocompleteModel m = model as KenTextAutocompleteModel;
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
    showSubmit = m.showSubmit;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenTextAutocompleteModel m = model as KenTextAutocompleteModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<Map<dynamic, dynamic>>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({'code': element['code'].toString(), 'value': element['value'].toString()});
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _KenTextAutocompleteState createState() => _KenTextAutocompleteState();
}

class _KenTextAutocompleteState extends State<KenTextAutocomplete> with KenWidgetStateMixin implements KenWidgetStateInterface {
  KenTextAutocompleteModel? _model;
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
    Widget autocomplete = runBuild(context, widget.id, widget.type, widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
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
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
        _options = _model!.data['rows'];
      }

      setDataLoad(widget.id, true);
    }

    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();
    IconThemeData iconTheme = _getIconTheme();

    String _displayStringForOption(Map<dynamic, dynamic> option) => option['value'];

    Widget children;

    children = Container(
        padding: widget.padding,
        decoration: widget.showborder!
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius!), border: Border.all(color: widget.borderColor!, width: widget.borderWidth!))
            : null,
        height: widget.height,
        child: RawAutocomplete<Map<dynamic, dynamic>>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return _options!.where((Map<dynamic, dynamic> option) {
              return option['value'].toString().toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          displayStringForOption: _displayStringForOption,
          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {

            String code = "";
            if (widget != null) {
              code = widget.callBack!(widget, KenCallbackType.fieldViewBuilder, _data,null) as String;
            }

            if (code.isNotEmpty && _data != null) {
              var currel = _data.firstWhere(
                  (element) => element['code'].toString() == code,
                  orElse: () => null as Map<String, String?>);
              if (currel != null) {
                textEditingController.text = currel['value'];
              }
            }

            return Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
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
                    validator: widget.clientValidator as String? Function(String?)?,
                    keyboardType: widget.keyboard,
                    obscureText: widget.keyboard == TextInputType.visiblePassword ? true : false,
                    onChanged: (value) {
                      if (widget.clientOnChange != null) widget.clientOnChange!(value);
                    },
                    decoration: InputDecoration(
                      labelStyle: captionStyle,
                      labelText: widget.label,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.underline! ? widget.borderColor! : Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.underline! ? widget.borderColor! : Colors.transparent),
                      ),
                    ),
                    onSaved: widget.clientOnSave as void Function(String?)?,
                  ),
                ),
              ),
              Container(
                color: iconTheme.color,
                padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
                child: GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).primaryColor,
                    size: iconTheme.size,
                  ),
                  onTap: () {
                    setState(() {

                      if (widget.callBack != null) {
                        widget.callBack!(widget, KenCallbackType.onTapSetState,code,null);
                      }

                    });
                  },
                ),
              )
            ]);
          },
          optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Map<dynamic, dynamic>> onSelected, Iterable<Map<dynamic, dynamic>> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                color: widget.backColor,
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<dynamic, dynamic> option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);

                          if (widget.callBack != null) {
                            widget.callBack!(widget, KenCallbackType.onTapOnSelected,option,null);
                          }

                          // SmeupVariablesService.setVariable(
                          //     widget.id, option['code'],
                          //     formKey: widget.formKey);
                          // SmeupVariablesService.setVariable(
                          //     "value", option['value'],
                          //     formKey: widget.formKey);
                          // if (_model != null)
                          //   SmeupDynamismService.run(_model!.dynamisms, context,
                          //       'change', widget.scaffoldKey, widget.formKey);
                          // if (widget.clientOnSelected != null)
                          //   widget.clientOnSelected!(option);

                        },
                        child: ListTile(
                          title: Text(
                            option['value'],
                            style: _getTextStile(),
                          ),
                        ),
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
          padding: EdgeInsets.all(0),
        );
      } else {

        if (widget.smeupButtons!=null) {
          button = widget.smeupButtons!;
        }
      }

      final column;
      if (button!= null) {
        column = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            children,
            SizedBox(
              height: 5,
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
    TextStyle style = KenThemeConfigurationService.getTheme()!.textTheme.bodyText1!;

    style = style.copyWith(color: widget.fontColor, fontSize: widget.fontSize, backgroundColor: widget.backColor);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenThemeConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(color: widget.captionFontColor, fontSize: widget.captionFontSize, backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenThemeConfigurationService.getTheme()!.iconTheme;

    return themeData;
  }
}

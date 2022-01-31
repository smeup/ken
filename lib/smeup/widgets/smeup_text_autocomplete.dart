import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/daos/smeup_text_autocomplete_dao.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_widget_state_interface.dart';

// ignore: must_be_immutable
class SmeupTextAutocomplete extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTextAutocompleteModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  // graphic properties
  Color backColor;
  double fontSize;
  Color fontColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;

  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  List<dynamic> data;
  bool underline;
  bool autoFocus;
  String title;
  String defaultValue;
  String valueField;
  String id;
  String type;
  bool showSubmit;
  String submitLabel;

  // other properties
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;
  Function clientOnSelected;
  Function clientOnSubmit;

  TextInputType keyboard;
  List<TextInputFormatter> inputFormatters;

  SmeupTextAutocomplete.withController(
      this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupTextAutocomplete(this.scaffoldKey, this.formKey,
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
      this.label = SmeupTextAutocompleteModel.defaultLabel,
      this.submitLabel = SmeupTextAutocompleteModel.defaultSubmitLabel,
      this.width = SmeupTextAutocompleteModel.defaultWidth,
      this.height = SmeupTextAutocompleteModel.defaultHeight,
      this.padding = SmeupTextAutocompleteModel.defaultPadding,
      this.showborder = SmeupTextAutocompleteModel.defaultShowBorder,
      this.data,
      this.underline = SmeupTextAutocompleteModel.defaultUnderline,
      this.autoFocus = SmeupTextAutocompleteModel.defaultAutoFocus,
      this.showSubmit = SmeupTextAutocompleteModel.defaultShowSubmit,
      this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.clientOnSelected,
      this.clientOnSubmit,
      this.keyboard,
      this.inputFormatters,
      this.defaultValue,
      this.valueField})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupTextAutocompleteModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextAutocompleteModel m = model;
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
  dynamic treatData(SmeupModel model) {
    SmeupTextAutocompleteModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<dynamic>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'code': element['code'].toString(),
          'value': element['value'].toString()
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupTextAutocompleteState createState() => _SmeupTextAutocompleteState();
}

class _SmeupTextAutocompleteState extends State<SmeupTextAutocomplete>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTextAutocompleteModel _model;
  dynamic _data;

  List<dynamic> _options;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupTextAutocompleteDao.getData(_model);
        _data = widget.treatData(_model);
        _options = _model.data['rows'];
      }

      setDataLoad(widget.id, true);
    }

    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();
    IconThemeData iconTheme = _getIconTheme();

    Widget children;

    children = Container(
        padding: widget.padding,
        decoration: widget.showborder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                    color: widget.borderColor, width: widget.borderWidth))
            : null,
        child: RawAutocomplete<dynamic>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return _options.where((dynamic option) {
              return option['value']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            String code = SmeupVariablesService.getVariable(widget.defaultValue,
                    formKey: widget.formKey) ??
                '';
            SmeupVariablesService.setVariable(widget.id, code,
                formKey: widget.formKey);

            if (code.isNotEmpty && _data != null) {
              var currel = _data.firstWhere(
                  (element) => element['code'].toString() == code,
                  orElse: () => null);
              if (currel != null) {
                textEditingController.text = currel['value'];
              }
            }

            return Row(children: [
              Expanded(
                child: TextFormField(
                  style: textStyle,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  inputFormatters: widget.inputFormatters,
                  autofocus: widget.autoFocus,
                  maxLines: 1,
                  key: Key('${widget.id}_text'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: true,
                  validator: widget.clientValidator,
                  keyboardType: widget.keyboard,
                  obscureText: widget.keyboard == TextInputType.visiblePassword
                      ? true
                      : false,
                  onChanged: (value) {
                    if (widget.clientOnChange != null)
                      widget.clientOnChange(value);
                  },
                  decoration: InputDecoration(
                    labelStyle: captionStyle,
                    labelText: widget.label,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.underline
                              ? widget.borderColor
                              : Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.underline
                              ? widget.borderColor
                              : Colors.transparent),
                    ),
                  ),
                  onSaved: widget.clientOnSave,
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(iconTheme.size.toDouble()),
                child: GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: iconTheme.color,
                    size: iconTheme.size,
                  ),
                  onTap: () {
                    setState(() {
                      SmeupVariablesService.setVariable(widget.defaultValue, '',
                          formKey: widget.formKey);
                      if (_model != null)
                        SmeupDynamismService.run(_model.dynamisms, context,
                            'change', widget.scaffoldKey, widget.formKey);
                    });
                  },
                ),
              )
            ]);
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<dynamic> onSelected,
              Iterable<dynamic> options) {
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
                      final dynamic option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option['value']);
                          SmeupVariablesService.setVariable(
                              widget.id, option['code'],
                              formKey: widget.formKey);
                          SmeupVariablesService.setVariable(
                              "value", option['value'],
                              formKey: widget.formKey);
                          if (_model != null)
                            SmeupDynamismService.run(_model.dynamisms, context,
                                'change', widget.scaffoldKey, widget.formKey);
                          if (widget.clientOnSelected != null)
                            widget.clientOnSelected(option);
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

    if (widget.showSubmit) {
      SmeupButtons button;
      if (_model == null) {
        button = SmeupButtons(
          widget.scaffoldKey,
          widget.formKey,
          data: [widget.submitLabel],
          clientOnPressed: widget.clientOnSubmit,
          padding: EdgeInsets.all(0),
        );
      } else {
        var json = {
          "type": "BTN",
          "data": {
            "rows": [
              {'value': widget.submitLabel},
            ]
          },
          "dynamisms": _model.dynamisms
        };
        button = SmeupButtons.withController(
            SmeupButtonsModel.fromMap(
                json, widget.formKey, widget.scaffoldKey, context),
            widget.scaffoldKey,
            widget.formKey);
      }
      final column = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          children,
          SizedBox(
            height: 5,
          ),
          button,
        ],
      );
      return SmeupWidgetBuilderResponse(_model, column);
    } else {
      return SmeupWidgetBuilderResponse(_model, children);
    }
  }

  TextStyle _getTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.bodyText1;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.caption;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme().iconTheme;

    return themeData;
  }
}

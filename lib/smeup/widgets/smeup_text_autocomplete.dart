import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_autocomplete_dao.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
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
  double fontsize;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  dynamic clientData;
  bool showUnderline;
  bool autoFocus;
  String title;
  String defaultValue;
  String valueField;

  // other properties
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;
  TextInputType keyboard;
  List<TextInputFormatter> inputFormatters;

  SmeupTextAutocomplete.withController(
      this.model, this.scaffoldKey, this.formKey) {
    runControllerActivities(model);
  }

  SmeupTextAutocomplete(this.scaffoldKey, this.formKey,
      {this.backColor,
      this.fontsize,
      this.label,
      this.width,
      this.height,
      this.padding,
      this.showborder,
      this.clientData,
      this.showUnderline,
      this.autoFocus,
      this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard,
      this.inputFormatters,
      this.defaultValue,
      this.valueField}) {
    model = SmeupTextAutocompleteModel(
        backColor: backColor,
        fontsize: fontsize,
        label: label,
        width: width,
        height: height,
        padding: padding,
        showborder: showborder,
        title: title,
        clientData: clientData,
        showUnderline: showUnderline,
        autoFocus: autoFocus,
        defaultValue: defaultValue,
        valueField: valueField);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextAutocompleteModel m = model;

    backColor = m.backColor;
    fontsize = m.fontsize;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showborder;
    title = m.title;
    clientData = m.clientData;
    showUnderline = m.showUnderline;
    autoFocus = m.autoFocus;
    defaultValue = m.defaultValue;
    valueField = m.valueField;
  }

  @override
  _SmeupTextAutocompleteState createState() => _SmeupTextAutocompleteState();
}

class _SmeupTextAutocompleteState extends State<SmeupTextAutocomplete>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTextAutocompleteModel _model;

  List<dynamic> _options;

  @override
  void initState() {
    _model = widget.model;
    widgetLoadType = _model.widgetLoadType;
    _options = _model.data['rows'];
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, _model.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget autocomplete =
        runBuild(context, _model.id, _model.type, widget.scaffoldKey,
            notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(_model.id, false);
      });
    });

    return autocomplete;
  }

  /// Label's structure:
  /// define the structure ...
  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    Widget textField;

    if (!getDataLoaded(_model.id) && widgetLoadType != LoadType.Delay) {
      _model.data = await SmeupTextAutocompleteDao.getData(_model);
      _options = _model.data['rows'];
      setDataLoad(_model.id, true);
    }

    if (!hasData(_model)) {
      return getFunErrorResponse(context, _model);
    }

    Color underlineColor = _model.showUnderline
        ? SmeupOptions.theme.primaryColor
        : Colors.transparent;

    Color focusColor = _model.showUnderline ? Colors.blue : Colors.transparent;

    textField = _model.widgetLoadType == LoadType.Delay
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: _model.showborder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: SmeupOptions.theme.primaryColor))
                : null,
            child: RawAutocomplete<dynamic>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return _options.where((dynamic option) {
                  return option['description']
                      .toString()
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                String code =
                    SmeupDynamismService.variables[widget.defaultValue] ?? '';
                SmeupDynamismService.variables[_model.id] = code;

                if (code.isNotEmpty &&
                    _model.data != null &&
                    _model.data['rows'] != null) {
                  var currel = (_model.data['rows'] as List).firstWhere(
                      (element) => element['code'].toString() == code,
                      orElse: () => null);
                  if (currel != null) {
                    textEditingController.text = currel['description'];
                  }
                }

                return Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                      inputFormatters: widget.inputFormatters,
                      autofocus: _model.autoFocus,
                      maxLines: 1,
                      //initialValue: value,
                      key: ValueKey(_model.id),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: true,
                      validator: widget.clientValidator,
                      keyboardType: widget.keyboard,
                      obscureText:
                          widget.keyboard == TextInputType.visiblePassword
                              ? true
                              : false,
                      onChanged: (value) {
                        if (widget.clientOnChange != null)
                          widget.clientOnChange(value);
                        SmeupDynamismService.variables[_model.id] = value;
                        SmeupDynamismService.run(_model.dynamisms, context,
                            'change', widget.scaffoldKey);
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: _model.fontsize,
                            color: SmeupOptions.theme.primaryColor),
                        labelText: _model.label,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: underlineColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: focusColor),
                        ),
                      ),
                      onSaved: widget.clientOnSave,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Icon(Icons.close, color: Colors.black38),
                      onTap: () {
                        setState(() {
                          SmeupDynamismService.variables[widget.defaultValue] =
                              '';
                          SmeupDynamismService.run(_model.dynamisms, context,
                              'change', widget.scaffoldKey);
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
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dynamic option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option['description']);
                              SmeupDynamismService.variables[_model.id] =
                                  option['code'];
                              SmeupDynamismService.run(_model.dynamisms,
                                  context, 'change', widget.scaffoldKey);
                            },
                            child: ListTile(
                              title: Text(option['description']),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ));

    if (_model.options != null &&
        _model.options['FLD']['default']['showSubmit'] != null &&
        _model.options['FLD']['default']['showSubmit']) {
      var json = {
        "type": "BTN",
        "data": [
          {'value': _model.options['FLD']['default']["submitLabel"]},
        ],
        "dynamisms": _model.dynamisms
      };
      final button = SmeupButtons(
          SmeupButtonsModel.fromMap(json), widget.scaffoldKey, widget.formKey);
      final column = Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textField,
          SizedBox(
            height: 5,
          ),
          button,
        ],
      );
      return SmeupWidgetBuilderResponse(_model, column);
    } else {
      return SmeupWidgetBuilderResponse(_model, textField);
    }
  }
}

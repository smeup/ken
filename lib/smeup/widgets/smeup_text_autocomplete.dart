import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_autocomplete_dao.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
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
  List<dynamic> data;
  bool showUnderline;
  bool autoFocus;
  String title;
  String defaultValue;
  String valueField;
  String id;
  String type;

  // other properties
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;
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
      this.fontsize,
      this.label,
      this.width,
      this.height,
      this.padding,
      this.showborder,
      this.data,
      this.showUnderline,
      this.autoFocus,
      this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard,
      this.inputFormatters,
      this.defaultValue,
      this.valueField})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextAutocompleteModel m = model;
    id = m.id;
    type = m.type;
    backColor = m.backColor;
    fontsize = m.fontsize;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showborder;
    title = m.title;
    showUnderline = m.showUnderline;
    autoFocus = m.autoFocus;
    defaultValue = m.defaultValue;
    valueField = m.valueField;

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
      data = newList;
    }
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
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    _options = widget.data == null ? [] : widget.data;
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
      await SmeupTextAutocompleteDao.getData(_model);
      _options = _model.data['rows'];
      setDataLoad(widget.id, true);
    }

    // if (widget.data == null) {
    //   return getFunErrorResponse(context, _model);
    // }

    Widget children;

    Color underlineColor = widget.showUnderline
        ? SmeupOptions.theme.primaryColor
        : Colors.transparent;

    Color focusColor = widget.showUnderline ? Colors.blue : Colors.transparent;

    children = Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: widget.showborder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: SmeupOptions.theme.primaryColor))
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
            String code =
                SmeupDynamismService.variables[widget.defaultValue] ?? '';
            SmeupDynamismService.variables[widget.id] = code;

            if (code.isNotEmpty && widget.data != null) {
              var currel = widget.data.firstWhere(
                  (element) => element['code'].toString() == code,
                  orElse: () => null);
              if (currel != null) {
                textEditingController.text = currel['value'];
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
                  autofocus: widget.autoFocus,
                  maxLines: 1,
                  key: ValueKey(widget.id),
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
                    labelStyle: TextStyle(
                        fontSize: widget.fontsize,
                        color: SmeupOptions.theme.primaryColor),
                    labelText: widget.label,
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
                      SmeupDynamismService.variables[widget.defaultValue] = '';
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
                          onSelected(option['value']);
                          SmeupDynamismService.variables[widget.id] =
                              option['code'];
                          SmeupDynamismService.run(_model.dynamisms, context,
                              'change', widget.scaffoldKey);
                        },
                        child: ListTile(
                          title: Text(option['value']),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ));

    if (_model != null &&
        _model.options != null &&
        _model.options['FLD']['default']['showSubmit'] != null &&
        _model.options['FLD']['default']['showSubmit']) {
      var json = {
        "type": "BTN",
        "data": {
          "rows": [
            {'value': _model.options['FLD']['default']["submitLabel"]},
          ]
        },
        "dynamisms": _model.dynamisms
      };
      final button = SmeupButtons.withController(
          SmeupButtonsModel.fromMap(json), widget.scaffoldKey, widget.formKey);
      final column = Column(
        //mainAxisSize: MainAxisSize.min,
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
}

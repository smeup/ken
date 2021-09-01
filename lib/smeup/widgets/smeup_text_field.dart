import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_field_dao.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_field_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupTextField extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTextFieldModel model;
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
  String id;
  String type;
  String valueField;
  bool showSubmit;
  TextInputType keyboard;

  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;

  List<TextInputFormatter> inputFormatters;

  SmeupTextField.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupTextField(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.backColor,
      this.fontsize = SmeupTextFieldModel.defaultFontsize,
      this.label,
      this.width = SmeupTextFieldModel.defaultWidth,
      this.height = SmeupTextFieldModel.defaultHeight,
      this.padding = SmeupTextFieldModel.defaultPadding,
      this.showborder = SmeupTextFieldModel.defaultShowBorder,
      this.clientData,
      this.showUnderline = SmeupTextFieldModel.defaultShowUnderline,
      this.autoFocus = SmeupTextFieldModel.defaultAutoFocus,
      this.valueField = SmeupTextFieldModel.defaultValueField,
      this.showSubmit = SmeupTextFieldModel.defaultShowSubmit,
      this.keyboard,
      this.clientValidator, // ?
      this.clientOnSave,
      this.clientOnChange,
      this.inputFormatters // ?
      })
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    this.model = SmeupTextFieldModel(
        id: id,
        type: type,
        backColor: backColor,
        fontsize: fontsize,
        label: label,
        width: width,
        height: height,
        padding: padding,
        showborder: showborder,
        showSubmit: showSubmit,
        clientData: clientData,
        showUnderline: showUnderline,
        autoFocus: autoFocus,
        valueField: valueField,
        keyboard: keyboard);
  }

  @override
  _SmeupTextFieldState createState() => _SmeupTextFieldState();

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextFieldModel m = model;
    id = m.id;
    type = m.type;
    backColor = m.backColor;
    fontsize = m.fontsize;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showborder;
    showSubmit = m.showSubmit;
    clientData = m.clientData;
    showUnderline = m.showUnderline;
    autoFocus = m.autoFocus;
    valueField = m.valueField;
    keyboard = m.keyboard;
  }
}

class _SmeupTextFieldState extends State<SmeupTextField>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTextFieldModel _model;

  @override
  void initState() {
    _model = widget.model;
    widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return input;
  }

  /// Input text's structure:
  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      await SmeupTextFieldDao.getData(_model);
      setDataLoad(widget.id, true);
    }

    // if (!hasData(_model)) {
    //   return getFunErrorResponse(context, _model);
    // }

    Widget textField;

    // String valueField = _model.optionsDefault == null ||
    //         _model.optionsDefault['valueField'] == null
    //     ? 'value'
    //     : _model.optionsDefault['valueField'];

    String value = '';
    if (_model.data != null) {
      value = _model.data['rows'][0][widget.valueField].toString();

      // final List cols = _model.data['columns'];
      // if (cols != null) {
      //   final col = cols.firstWhere(
      //       (element) => element['code'] == widget.valueField,
      //       orElse: () => null);
      //   if (col['ogg'] == 'D8*YYMD') {
      //     value = DateFormat("dd/MM/yyyy").format(DateTime.tryParse(value));
      //   }
      // }
    }

    SmeupDynamismService.variables[widget.id] = value;

    Color underlineColor = widget.showUnderline
        ? SmeupOptions.theme.primaryColor
        : Colors.transparent;

    Color focusColor = widget.showUnderline ? Colors.blue : Colors.transparent;

    textField = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: widget.showborder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: SmeupOptions.theme.primaryColor))
            : null,
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autoFocus,
          maxLines: 1,
          initialValue: value,
          key: Key('${widget.id}_text'),
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          enableSuggestions: true,
          validator: widget.clientValidator,
          keyboardType: widget.keyboard,
          obscureText:
              widget.keyboard == TextInputType.visiblePassword ? true : false,
          onChanged: (value) {
            if (widget.clientOnChange != null) widget.clientOnChange(value);
            SmeupDynamismService.variables[widget.id] = value;
            SmeupDynamismService.run(
                _model.dynamisms, context, 'change', widget.scaffoldKey);
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
          onSaved: (value) {
            if (widget.clientOnSave != null) widget.clientOnSave(value);
            SmeupDynamismService.variables[widget.id] = value;
            SmeupDynamismService.run(
                _model.dynamisms, context, 'lostfocus', widget.scaffoldKey);
          }, // lostfocus
        ));

    if (widget.showSubmit) {
      var json = {
        "type": "BTN",
        "data": [
          {'value': _model.options['FLD']['default']["submitLabel"]},
        ],
        "dynamisms": _model.dynamisms
      };
      final button = SmeupButtons.withController(
          SmeupButtonsModel.fromMap(
            json,
          ),
          widget.scaffoldKey,
          widget.formKey);
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

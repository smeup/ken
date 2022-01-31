import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/daos/smeup_text_field_dao.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_field_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupTextField extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTextFieldModel model;
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

  bool underline;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;
  String data;
  bool autoFocus;
  String id;
  String type;
  String valueField;
  bool showSubmit;
  String submitLabel;
  TextInputType keyboard;
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;
  Function clientOnSubmit;

  List<TextInputFormatter> inputFormatters;

  SmeupTextField.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupTextField(this.scaffoldKey, this.formKey,
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
      this.underline = SmeupTextFieldModel.defaultUnderline,
      this.label = SmeupTextFieldModel.defaultLabel,
      this.submitLabel = SmeupTextFieldModel.defaultSubmitLabel,
      this.width = SmeupTextFieldModel.defaultWidth,
      this.height = SmeupTextFieldModel.defaultHeight,
      this.padding = SmeupTextFieldModel.defaultPadding,
      this.showBorder = SmeupTextFieldModel.defaultShowBorder,
      this.autoFocus = SmeupTextFieldModel.defaultAutoFocus,
      this.valueField = SmeupTextFieldModel.defaultValueField,
      this.showSubmit = SmeupTextFieldModel.defaultShowSubmit,
      this.data,
      this.keyboard,
      this.clientValidator, // ?
      this.clientOnSave,
      this.clientOnChange,
      this.clientOnSubmit,
      this.inputFormatters // ?
      })
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupTextFieldModel.setDefaults(this);
  }

  @override
  _SmeupTextFieldState createState() => _SmeupTextFieldState();

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextFieldModel m = model;
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
    underline = m.underline;
    label = m.label;
    submitLabel = m.submitLabel;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showBorder = m.showBorder;
    showSubmit = m.showSubmit;
    autoFocus = m.autoFocus;
    valueField = m.valueField;
    keyboard = m.keyboard;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupTextFieldModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null &&
        (workData['rows'] as List).length > 0 &&
        workData['rows'][0][m.valueField] != null) {
      return workData['rows'][0][m.valueField].toString();
    } else {
      return m.data;
    }
  }
}

class _SmeupTextFieldState extends State<SmeupTextField>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTextFieldModel _model;
  dynamic _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
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
      if (_model != null) {
        await SmeupTextFieldDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();

    Widget textField;

    SmeupVariablesService.setVariable(widget.id, _data,
        formKey: widget.formKey);

    textField = Container(
        alignment: Alignment.centerLeft,
        padding: widget.padding,
        decoration: widget.showBorder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                    color: widget.borderColor, width: widget.borderWidth))
            : null,
        child: TextFormField(
          style: textStyle,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autoFocus,
          maxLines: 1,
          initialValue: _data,
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
            SmeupVariablesService.setVariable(widget.id, value,
                formKey: widget.formKey);
            if (_model != null)
              SmeupDynamismService.run(_model.dynamisms, context, 'change',
                  widget.scaffoldKey, widget.formKey);
            _data = value;
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
          onSaved: (value) {
            if (widget.clientOnSave != null) widget.clientOnSave(value);
            SmeupVariablesService.setVariable(widget.id, value,
                formKey: widget.formKey);
            if (_model != null)
              SmeupDynamismService.run(_model.dynamisms, context, 'lostfocus',
                  widget.scaffoldKey, widget.formKey);
          }, // lostfocus
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
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_password_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_password_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_password_rule_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_field.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_password_indicators.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SmeupTextPassword extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTextPasswordModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color backColor;
  double fontsize;

  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;
  String data;
  bool underline;
  bool autoFocus;
  String id;
  String type;
  String valueField;
  bool showSubmit;
  bool showRules;
  bool showRulesIcon;
  bool checkRules;

  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;

  List<TextInputFormatter> inputFormatters;

  SmeupTextPassword.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupTextPassword(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.backColor,
      this.fontsize = SmeupTextPasswordModel.defaultFontsize,
      this.label,
      this.width = SmeupTextPasswordModel.defaultWidth,
      this.height = SmeupTextPasswordModel.defaultHeight,
      this.padding = SmeupTextPasswordModel.defaultPadding,
      this.showBorder = SmeupTextPasswordModel.defaultShowBorder,
      this.data,
      this.underline = SmeupTextPasswordModel.defaultShowUnderline,
      this.autoFocus = SmeupTextPasswordModel.defaultAutoFocus,
      this.valueField = SmeupTextPasswordModel.defaultValueField,
      this.showSubmit = SmeupTextPasswordModel.defaultShowSubmit,
      this.showRules = SmeupTextPasswordModel.defaultShowRules,
      this.showRulesIcon = SmeupTextPasswordModel.defaultShowRulesIcon,
      this.checkRules = SmeupTextPasswordModel.defaultCheckRules,
      this.clientValidator, // ?
      this.clientOnSave,
      this.clientOnChange,
      this.inputFormatters // ?
      })
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextPasswordModel m = model;
    id = m.id;
    type = m.type;
    backColor = m.backColor;
    fontsize = m.fontsize;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showBorder = m.showBorder;
    showRules = m.showRules;
    checkRules = m.checkRules;
    showRulesIcon = m.showRulesIcon;
    showSubmit = m.showSubmit;
    underline = m.showUnderline;
    autoFocus = m.autoFocus;
    valueField = m.valueField;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupTextPasswordModel m = model;

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

  @override
  _SmeupTextPasswordState createState() => _SmeupTextPasswordState();
}

class _SmeupTextPasswordState extends State<SmeupTextPassword>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTextPasswordModel _model;
  dynamic _data;
  bool _passwordVisible;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    _passwordVisible = false;
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
    final password = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return password;
  }

  /// Input text's structure:
  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupTextPasswordDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    final passwordModel =
        Provider.of<SmeupTextPasswordRuleModel>(context, listen: false);

    final children = Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: SmeupTextField(widget.scaffoldKey, widget.formKey,
                      id: widget.id,
                      label: widget.label,
                      autoFocus: widget.autoFocus,
                      backColor: widget.backColor,
                      fontSize: widget.fontsize,
                      height: widget.height,
                      inputFormatters: widget.inputFormatters,
                      padding: widget.padding,
                      showSubmit: widget.showSubmit,
                      showBorder: widget.showBorder,
                      width: widget.width,
                      underline: widget.underline,
                      data: _data,
                      clientValidator: widget.clientValidator,
                      clientOnSave: widget.clientOnSave,
                      clientOnChange: (value) {
                    widget.clientOnChange(value);
                    passwordModel.checkProgress(value);
                    _data = value;
                  },
                      keyboard: _passwordVisible
                          ? TextInputType.text
                          : TextInputType.visiblePassword),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    child: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black38),
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    child: Icon(Icons.close, color: Colors.black38),
                    onTap: () {
                      setState(() {
                        _data = '';
                        passwordModel.reset();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (!widget.underline)
                Divider(
                  color: Colors.black38,
                  thickness: 1.5,
                ),
              if (widget.showRules)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SmeupTextPasswordIndicators(widget.showRulesIcon),
                )
            ],
          )
        ],
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}

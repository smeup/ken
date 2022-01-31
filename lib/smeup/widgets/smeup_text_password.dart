import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/daos/smeup_text_password_dao.dart';
import 'package:ken/smeup/models/notifiers/smeup_text_password_visibility_notifier.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_password_model.dart';
import 'package:ken/smeup/models/notifiers/smeup_text_password_rule_notifier.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_text_field.dart';
import 'package:ken/smeup/widgets/smeup_text_password_indicators.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SmeupTextPassword extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTextPasswordModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

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
  String submitLabel;
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
  Function clientOnSubmit;

  List<TextInputFormatter> inputFormatters;

  SmeupTextPassword.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupTextPassword(this.scaffoldKey, this.formKey,
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
      this.label = SmeupTextPasswordModel.defaultLabel,
      this.submitLabel = SmeupTextPasswordModel.defaultSubmitLabel,
      this.width = SmeupTextPasswordModel.defaultWidth,
      this.height = SmeupTextPasswordModel.defaultHeight,
      this.padding = SmeupTextPasswordModel.defaultPadding,
      this.showBorder = SmeupTextPasswordModel.defaultShowBorder,
      this.data,
      this.underline = SmeupTextPasswordModel.defaultUnderline,
      this.autoFocus = SmeupTextPasswordModel.defaultAutoFocus,
      this.valueField = SmeupTextPasswordModel.defaultValueField,
      this.showSubmit = SmeupTextPasswordModel.defaultShowSubmit,
      this.showRules = SmeupTextPasswordModel.defaultShowRules,
      this.showRulesIcon = SmeupTextPasswordModel.defaultShowRulesIcon,
      this.checkRules = SmeupTextPasswordModel.defaultCheckRules,
      this.clientValidator, // ?
      this.clientOnSave,
      this.clientOnChange,
      this.inputFormatters, // ?
      this.clientOnSubmit})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupTextPasswordModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTextPasswordModel m = model;
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
    submitLabel = m.submitLabel;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showBorder = m.showBorder;
    showRules = m.showRules;
    checkRules = m.checkRules;
    showRulesIcon = m.showRulesIcon;
    showSubmit = m.showSubmit;
    underline = m.underline;
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
      return '';
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
  // bool _passwordVisible;

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
        Provider.of<SmeupTextPasswordRuleNotifier>(context, listen: false);
    final passwordFieldModel = Provider.of<SmeupTextPasswordVisibilityNotifier>(
        context,
        listen: false);

    final iconTheme = _getIconTheme();
    final dividerStyle = _getDividerStyle();
    final captionStyle = _getCaptionStile();

    final children = Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Consumer<SmeupTextPasswordVisibilityNotifier>(
                    builder: (context, fieldmodel, child) {
                      return SmeupTextField(widget.scaffoldKey, widget.formKey,
                          id: widget.id,
                          label: widget.label,
                          autoFocus: widget.autoFocus,
                          backColor: widget.backColor,
                          fontSize: widget.fontSize,
                          fontBold: widget.fontBold,
                          fontColor: widget.fontColor,
                          captionBackColor: widget.captionBackColor,
                          captionFontBold: widget.captionFontBold,
                          captionFontColor: widget.captionFontColor,
                          captionFontSize: widget.captionFontSize,
                          borderColor: widget.borderColor,
                          borderRadius: widget.borderRadius,
                          borderWidth: widget.borderWidth,
                          submitLabel: widget.submitLabel,
                          clientOnSubmit: widget.clientOnSubmit,
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
                        if (widget.clientOnChange != null)
                          widget.clientOnChange(value);
                        passwordModel.checkProgress(value);
                        _data = value;
                      },
                          keyboard: fieldmodel.passwordVisible
                              ? TextInputType.text
                              : TextInputType.visiblePassword);
                    },
                  ),
                ),
                Container(
                  color: iconTheme.color,
                  padding: EdgeInsets.all(iconTheme.size.toDouble()),
                  child: GestureDetector(
                    child: Icon(
                      passwordFieldModel.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                      size: iconTheme.size,
                    ),
                    onTap: () {
                      passwordFieldModel.toggleVisible();
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  color: iconTheme.color,
                  padding: EdgeInsets.all(iconTheme.size.toDouble()),
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                      size: iconTheme.size,
                    ),
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
                  thickness: dividerStyle.thickness,
                  color: dividerStyle.color,
                ),
              if (widget.showRules)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SmeupTextPasswordIndicators(
                      widget.showRulesIcon, captionStyle, iconTheme),
                )
            ],
          )
        ],
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme().iconTheme;

    return themeData;
  }

  DividerThemeData _getDividerStyle() {
    DividerThemeData dividerData = SmeupConfigurationService.getTheme()
        .dividerTheme
        .copyWith(color: widget.fontColor);

    return dividerData;
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

// import 'dart:ui';

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/notifiers/ken_text_password_rule_notifier.dart';
import '../models/notifiers/ken_text_password_visibility_notifier.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_text_password_model.dart';
import '../services/ken_utilities.dart';
import 'kenTextField.dart';
import 'kenTextPasswordIndicators.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';
import 'package:provider/provider.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenTextPassword extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenTextPasswordModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

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
  double? iconSize;
  Color? iconColor;
  Color? buttonBackColor;

  String? label;
  String? submitLabel;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  String? data;
  bool? underline;
  bool? autoFocus;
  String? id;
  String? type;
  String? valueField;
  bool? showSubmit;
  bool? showRules;
  bool? showRulesIcon;
  bool? checkRules;

  Function? clientValidator;
  //Function? clientOnSave;
  //Function? clientOnChange;
  Function? clientOnSubmit;

  List<TextInputFormatter>? inputFormatters;

  KenTextPassword.withController(
    KenTextPasswordModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenTextPassword(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
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
    this.iconSize,
    this.iconColor,
    this.buttonBackColor,
    this.label = KenTextPasswordModel.defaultLabel,
    this.submitLabel = KenTextPasswordModel.defaultSubmitLabel,
    this.width = KenTextPasswordModel.defaultWidth,
    this.height = KenTextPasswordModel.defaultHeight,
    this.padding = KenTextPasswordModel.defaultPadding,
    this.showBorder = KenTextPasswordModel.defaultShowBorder,
    this.data,
    this.underline = KenTextPasswordModel.defaultUnderline,
    this.autoFocus = KenTextPasswordModel.defaultAutoFocus,
    this.valueField = KenTextPasswordModel.defaultValueField,
    this.showSubmit = KenTextPasswordModel.defaultShowSubmit,
    this.showRules = KenTextPasswordModel.defaultShowRules,
    this.showRulesIcon = KenTextPasswordModel.defaultShowRulesIcon,
    this.checkRules = KenTextPasswordModel.defaultCheckRules,
    this.clientValidator, // ?
    //this.clientOnSave,
    //this.clientOnChange,
    this.inputFormatters, // ?
    this.clientOnSubmit,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenTextPasswordModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenTextPasswordModel m = model as KenTextPasswordModel;
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
    iconSize = m.iconSize;
    iconColor = m.iconColor;
    buttonBackColor = m.buttonBackColor;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenTextPasswordModel m = model as KenTextPasswordModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null &&
        (workData['rows'] as List).isNotEmpty &&
        workData['rows'][0][m.valueField] != null) {
      return workData['rows'][0][m.valueField].toString();
    } else {
      return '';
    }
  }

  @override
  _KenTextPasswordState createState() => _KenTextPasswordState();
}

class _KenTextPasswordState extends State<KenTextPassword>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenTextPasswordModel? _model;
  dynamic _data;
  // bool _passwordVisible;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupTextPasswordDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    final passwordModel =
        Provider.of<KenTextPasswordRuleNotifier>(context, listen: false);
    final passwordFieldModel =
        Provider.of<KenTextPasswordVisibilityNotifier>(context, listen: false);

    final iconTheme = _getIconTheme();
    final dividerStyle = _getDividerStyle();
    final captionStyle = _getCaptionStile();

    final children = Column(
      children: [
        Container(
          decoration: widget.showBorder!
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  border: Border.all(
                      color: widget.borderColor!, width: widget.borderWidth!))
              : null,
          child: Row(
            children: [
              Expanded(
                child: Consumer<KenTextPasswordVisibilityNotifier>(
                  builder: (context, fieldmodel, child) {
                    return KenTextField(widget.scaffoldKey, widget.formKey,
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
                        showBorder: false,
                        width: widget.width,
                        underline: false,
                        data: _data,
                        clientValidator: widget.clientValidator,
                        //clientOnSave: widget.clientOnSave,
                        //clientOnChange: (value) {
                        //if (widget.clientOnChange != null)
                        //  widget.clientOnChange!(value);
                        //passwordModel.checkProgress(value);
                        //_data = value;
                        //},

                        keyboard: fieldmodel.passwordVisible
                            ? TextInputType.text
                            : TextInputType.visiblePassword);
                  },
                ),
              ),
              Container(
                color: widget.buttonBackColor,
                padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
                child: GestureDetector(
                  child: Icon(
                    passwordFieldModel.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: iconTheme.color,
                    size: iconTheme.size,
                  ),
                  onTap: () {
                    setState(() {
                      passwordFieldModel.toggleVisible();
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                color: widget.buttonBackColor,
                padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
                child: GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: iconTheme.color,
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
            if (widget.underline!)
              Divider(
                thickness: dividerStyle.thickness,
                color: dividerStyle.color,
              ),
            if (widget.showRules!)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: KenTextPasswordIndicators(
                    widget.showRulesIcon, captionStyle, iconTheme),
              )
          ],
        )
      ],
    );

    return KenWidgetBuilderResponse(_model, children);
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }

  DividerThemeData _getDividerStyle() {
    DividerThemeData dividerData = KenConfigurationService.getTheme()!
        .dividerTheme
        .copyWith(color: widget.fontColor);

    return dividerData;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}

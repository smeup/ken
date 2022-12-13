import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_text_field_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenButtons.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

import '../services/ken_theme_configuration_service.dart';

// ignore: must_be_immutable
class KenTextField extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenTextFieldModel? model;
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

  bool? underline;
  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  String? data;
  bool? autoFocus;
  String? id;
  String? type;
  String? valueField;
  bool? showSubmit;
  String? submitLabel;
  KenButtons? smeupButtons;

  TextInputType? keyboard;
  Function? clientValidator;
  Function? clientOnSave;
  Function? clientOnChange;
  Function? clientOnSubmit;

  List<TextInputFormatter>? inputFormatters;

  Future<dynamic> Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenTextField.withController(
    KenTextFieldModel this.model,
    this.scaffoldKey,
    this.formKey,
    this.smeupButtons,
    this.callBack,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenTextField(this.scaffoldKey, this.formKey,
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
      this.underline = KenTextFieldModel.defaultUnderline,
      this.label = KenTextFieldModel.defaultLabel,
      this.submitLabel = KenTextFieldModel.defaultSubmitLabel,
      this.width = KenTextFieldModel.defaultWidth,
      this.height = KenTextFieldModel.defaultHeight,
      this.padding = KenTextFieldModel.defaultPadding,
      this.showBorder = KenTextFieldModel.defaultShowBorder,
      this.autoFocus = KenTextFieldModel.defaultAutoFocus,
      this.valueField = KenTextFieldModel.defaultValueField,
      this.showSubmit = KenTextFieldModel.defaultShowSubmit,
      this.data,
      this.keyboard,
      this.clientValidator, // ?
      this.clientOnSave,
      this.clientOnChange,
      this.clientOnSubmit,
      this.inputFormatters // ?
      })
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenTextFieldModel.setDefaults(this);
  }

  @override
  _KenTextFieldState createState() => _KenTextFieldState();

  @override
  runControllerActivities(KenModel model) {
    KenTextFieldModel m = model as KenTextFieldModel;
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
  dynamic treatData(KenModel model) {
    KenTextFieldModel m = model as KenTextFieldModel;

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

class _KenTextFieldState extends State<KenTextField>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenTextFieldModel? _model;
  dynamic _data;

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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupTextFieldDao.getData(_model!);
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();

    Widget textField;

    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.getChildren, _data, null);
    }

    textField = Container(
        alignment: Alignment.centerLeft,
        padding: widget.padding,
        decoration: widget.showBorder!
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                border: Border.all(
                    color: widget.borderColor!, width: widget.borderWidth!))
            : null,
        child: TextFormField(
          style: textStyle,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autoFocus!,
          maxLines: 1,
          initialValue: _data,
          key: Key('${widget.id}_text'),
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          enableSuggestions: true,
          validator: widget.clientValidator as String? Function(String?)?,
          keyboardType: widget.keyboard,
          obscureText:
              widget.keyboard == TextInputType.visiblePassword ? true : false,
          onChanged: (value) {
            if (widget.callBack != null) {
              widget.callBack!(widget, KenCallbackType.onChanged, value, null);
            }
            //
            // if (widget.clientOnChange != null) widget.clientOnChange!(value);
            // SmeupVariablesService.setVariable(widget.id, value,
            //     formKey: widget.formKey);
            // if (_model != null)
            //   SmeupDynamismService.run(_model!.dynamisms, context, 'change',
            //       widget.scaffoldKey, widget.formKey);

            _data = value;
          },
          decoration: InputDecoration(
            labelStyle: captionStyle,
            labelText: widget.label,
            // errorBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.transparent),
            // ),
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
          onSaved: (value) {
            if (widget.callBack != null) {
              widget.callBack!(widget, KenCallbackType.onSaved, value, null);
            }
            //
            // if (widget.clientOnSave != null) widget.clientOnSave!(value);
            // SmeupVariablesService.setVariable(widget.id, value,
            //     formKey: widget.formKey);
            // if (_model != null)
            //   SmeupDynamismService.run(_model!.dynamisms, context, 'lostfocus',
            //       widget.scaffoldKey, widget.formKey);
          }, // lostfocus
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
        if (widget.smeupButtons != null) {
          button = widget.smeupButtons!;
        }
      }

      final column;
      if (button != null) {
        column = Column(
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
      } else {
        column = Container();
      }

      return KenWidgetBuilderResponse(_model, column);
    } else {
      return KenWidgetBuilderResponse(_model, textField);
    }
  }

  TextStyle _getTextStile() {
    TextStyle style =
        KenThemeConfigurationService.getTheme()!.textTheme.bodyText1!;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style =
        KenThemeConfigurationService.getTheme()!.textTheme.caption!;

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

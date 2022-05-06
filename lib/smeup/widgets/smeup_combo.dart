import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_combo_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_combo_widget.dart';
import 'package:ken/smeup/widgets/smeup_line.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

import '../models/widgets/smeup_section_model.dart';
import '../services/smeup_dynamism_service.dart';

// ignore: must_be_immutable
class SmeupCombo extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  Color? backColor;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  double? iconSize;
  Color? iconColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;

  bool? underline;
  double? innerSpace;
  Alignment? align;
  SmeupComboModel? model;
  EdgeInsetsGeometry? padding;
  List<SmeupComboItemModel>? data;
  String? id;
  String? type;
  String? title;
  String? selectedValue;
  String? valueField;
  String? label;
  String? descriptionField;
  double? width;
  double? height;
  bool? showBorder;
  void Function(String? newValue)? clientOnChange;

  SmeupCombo(
    this.scaffoldKey,
    this.formKey, {
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.backColor,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.iconSize,
    this.iconColor,
    this.underline = SmeupComboModel.defaultUnderline,
    this.title,
    this.id = '',
    this.type = 'CMB',
    this.selectedValue = '',
    this.data,
    this.align = SmeupComboModel.defaultAlign,
    this.innerSpace = SmeupComboModel.defaultInnerSpace,
    this.padding = SmeupComboModel.defaultPadding,
    this.label = SmeupComboModel.defaultLabel,
    this.valueField = SmeupComboModel.defaultValueField,
    this.descriptionField = SmeupComboModel.defaultDescriptionField,
    this.width = SmeupComboModel.defaultWidth,
    this.height = SmeupComboModel.defaultHeight,
    this.showBorder = SmeupComboModel.defaultShowBorder,
    this.clientOnChange,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupComboModel.setDefaults(this);
  }

  SmeupCombo.withController(
    SmeupComboModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupComboModel m = model as SmeupComboModel;
    id = m.id;
    type = m.type;
    title = m.title;
    padding = m.padding;
    valueField = m.valueField;
    descriptionField = m.descriptionField;
    selectedValue = m.selectedValue;
    label = m.label;
    fontSize = m.fontSize;
    fontColor = m.fontColor;
    fontBold = m.fontBold;
    backColor = m.backColor;
    underline = m.underline;
    iconSize = m.iconSize;
    iconColor = m.iconColor;
    captionFontBold = m.captionFontBold;
    captionFontSize = m.captionFontSize;
    captionFontColor = m.captionFontColor;
    captionBackColor = m.captionBackColor;
    borderColor = m.borderColor;
    borderRadius = m.borderRadius;
    borderWidth = m.borderWidth;
    align = m.align;
    innerSpace = m.innerSpace;
    width = m.width;
    height = m.height;
    showBorder = m.showBorder;
    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupComboModel m = model as SmeupComboModel;

    // change data format
    var workData = formatDataFields(m);

    //set the widget data
    if (workData != null) {
      var newList = List<SmeupComboItemModel>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(SmeupComboItemModel(element[m.valueField].toString(),
            element[m.descriptionField].toString()));
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupComboState createState() => _SmeupComboState();
}

class _SmeupComboState extends State<SmeupCombo>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupComboModel? _model;
  List<SmeupComboItemModel>? _data;
  String? _selectedValue;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    _selectedValue = widget.selectedValue;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget combo = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return combo;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupComboDao.getData(_model!);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    SmeupVariablesService.setVariable(widget.id, _selectedValue,
        formKey: widget.formKey);

    var text = widget.label!.isEmpty
        ? Container()
        : Text(widget.label!,
            textAlign: TextAlign.center, style: _getCaptionStile());

    double boxHeight = widget.height!;
    if (boxHeight == 0) {
      if (_model != null && _model!.parent != null) {
        boxHeight = (_model!.parent as SmeupSectionModel).height!;
      } else {
        boxHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      }
    }

    double? boxWidth = widget.width;
    if (boxWidth == 0) {
      if (_model != null && _model!.parent != null) {
        boxWidth = (_model!.parent as SmeupSectionModel).width;
      } else {
        boxWidth = SmeupUtilities.getDeviceInfo().safeWidth;
      }
    }

    final combo = Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: widget.padding,
          width: boxWidth,
          height: boxHeight,
          decoration: widget.showBorder!
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  border: Border.all(
                      color: widget.borderColor!, width: widget.borderWidth!))
              : null,
          child: SmeupComboWidget(
            widget.scaffoldKey,
            widget.formKey,
            data: _data,
            fontColor: widget.fontColor,
            fontSize: widget.fontSize,
            fontBold: widget.fontBold,
            backColor: widget.backColor,
            iconColor: widget.iconColor,
            iconSize: widget.iconSize,
            captionFontBold: widget.captionFontBold,
            captionFontColor: widget.captionFontColor,
            captionFontSize: widget.captionFontSize,
            captionBackColor: widget.captionBackColor,
            selectedValue: _selectedValue,
            clientOnChange: (String? newValue) {
              _selectedValue = newValue;
              SmeupVariablesService.setVariable(widget.id, newValue,
                  formKey: widget.formKey);
              if (widget.clientOnChange != null) {
                widget.clientOnChange!(newValue);
              }
              if (_model != null)
                SmeupDynamismService.run(_model!.dynamisms, context, 'change',
                    widget.scaffoldKey, widget.formKey);
            },
          )),
    );

    var line = widget.underline!
        ? SmeupLine(widget.scaffoldKey, widget.formKey)
        : Container();

    var children;

    if (widget.align == Alignment.centerLeft) {
      children = Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(width: widget.innerSpace),
            Expanded(child: Align(child: combo, alignment: widget.align!)),
          ],
        ),
        line
      ]);
    } else if (widget.align == Alignment.centerRight) {
      children = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Align(
                child: combo,
                alignment: widget.align!,
              )),
              SizedBox(width: widget.innerSpace),
              text,
            ],
          ),
          line
        ],
      );
    } else if (widget.align == Alignment.topCenter) {
      children = Container(
        height: boxHeight,
        width: boxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: text,
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              child: combo,
              alignment: Alignment.centerLeft,
            ),
            line
          ],
        ),
      );
    } else if (widget.align == Alignment.bottomCenter) {
      children = Container(
        height: boxHeight,
        width: boxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: combo,
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              child: text,
              alignment: Alignment.centerLeft,
            ),
            line
          ],
        ),
        //color: widget.backColor,
      );
    } else // center
    {
      children = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            combo,
            SizedBox(width: widget.innerSpace),
            Expanded(child: text),
          ],
        ),
        //color: widget.backColor,
      );
    }

    return SmeupWidgetBuilderResponse(_model, children);
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}

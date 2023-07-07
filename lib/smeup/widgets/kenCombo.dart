import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_combo_item_model.dart';
import 'package:ken/smeup/models/widgets/ken_combo_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenComboWidget.dart';
import 'package:ken/smeup/widgets/kenLine.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

import '../models/KenMessageBusEventData.dart';
import '../models/widgets/ken_section_model.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_message_bus.dart';

// ignore: must_be_immutable
class KenCombo extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
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
  KenComboModel? model;
  EdgeInsetsGeometry? padding;
  List<KenComboItemModel>? data;
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

  //Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenCombo(
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
    this.underline = KenComboModel.defaultUnderline,
    this.title,
    this.id = '',
    this.type = 'CMB',
    this.selectedValue = '',
    this.data,
    this.align = KenComboModel.defaultAlign,
    this.innerSpace = KenComboModel.defaultInnerSpace,
    this.padding = KenComboModel.defaultPadding,
    this.label = KenComboModel.defaultLabel,
    this.valueField = KenComboModel.defaultValueField,
    this.descriptionField = KenComboModel.defaultDescriptionField,
    this.width = KenComboModel.defaultWidth,
    this.height = KenComboModel.defaultHeight,
    this.showBorder = KenComboModel.defaultShowBorder,
    this.clientOnChange,
    //this.callBack
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenComboModel.setDefaults(this);
  }

  KenCombo.withController(
    KenComboModel this.model,
    this.scaffoldKey,
    this.formKey,
    //this.callBack
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenComboModel m = model as KenComboModel;
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
  dynamic treatData(KenModel model) {
    KenComboModel m = model as KenComboModel;

    // change data format
    var workData = formatDataFields(m);

    //set the widget data
    if (workData != null) {
      var newList = List<KenComboItemModel>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(KenComboItemModel(element[m.valueField].toString(),
            element[m.descriptionField].toString()));
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _KenComboState createState() => _KenComboState();
}

class _KenComboState extends State<KenCombo>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenComboModel? _model;
  List<KenComboItemModel>? _data;
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupComboDao.getData(_model!);
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    // if (widget.callBack != null) {
    //   widget.callBack!(
    //       widget, KenCallbackType.getChildren, _selectedValue, null);
    // }

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.comboGetChildren,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );

    var text = widget.label!.isEmpty
        ? Container()
        : Text(widget.label!,
            textAlign: TextAlign.center, style: _getCaptionStile());

    double boxHeight = widget.height!;
    if (boxHeight == 0) {
      if (_model != null && _model!.parent != null) {
        boxHeight = (_model!.parent as KenSectionModel).height!;
      } else {
        boxHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
    }

    double? boxWidth = widget.width;
    if (boxWidth == 0) {
      if (_model != null && _model!.parent != null) {
        boxWidth = (_model!.parent as KenSectionModel).width;
      } else {
        boxWidth = KenUtilities.getDeviceInfo().safeWidth;
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
          child: KenComboWidget(
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

              // if (widget.callBack != null) {
              //   widget.callBack!(widget, KenCallbackType.onClientChange,
              //       _selectedValue, null);
              // }

              KenMessageBus.instance.publishRequest(
                widget.globallyUniqueId,
                KenTopic.comboOnClientChange,
                KenMessageBusEventData(
                    context: context,
                    widget: widget,
                    model: _model,
                    data: _selectedValue),
              );

              if (widget.clientOnChange != null) {
                widget.clientOnChange!(newValue);
              }
            },
          )),
    );

    var line = widget.underline!
        ? KenLine(widget.scaffoldKey, widget.formKey)
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

    return KenWidgetBuilderResponse(_model, children);
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.caption!;

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

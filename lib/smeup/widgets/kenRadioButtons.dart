import 'package:flutter/material.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_radio_buttons_model.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenNotAvailable.dart';
import 'package:ken/smeup/widgets/kenRadioButton.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

import '../services/ken_theme_configuration_service.dart';

// import '../services/ken_theme_configuration_service.dart';

// ignore: must_be_immutable
class KenRadioButtons extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenRadioButtonsModel? model;
  KenRadioButtonsModel? smeupRadioButtonsModel;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? radioButtonColor;
  Color? fontColor;
  double? fontSize;
  Color? backColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  Function? clientOnPressed;
  EdgeInsetsGeometry? padding;
  double? width;
  double? height;
  Alignment? align;
  List<dynamic>? data;
  String? valueField;
  String? displayedField;
  String? selectedValue;
  int? columns;
  String? id;
  String? type;
  String? title;

  Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenRadioButtons.withController(
      KenRadioButtonsModel this.model,
      this.scaffoldKey,
      this.formKey,
      this.id,
      this.selectedValue,
      this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenRadioButtons(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.title = '',
      this.radioButtonColor,
      this.fontSize,
      this.fontColor,
      this.backColor,
      this.fontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.captionFontBold,
      this.data,
      this.width = KenRadioButtonsModel.defaultWidth,
      this.height = KenRadioButtonsModel.defaultHeight,
      this.align = KenRadioButtonsModel.defaultAlign,
      this.padding = KenRadioButtonsModel.defaultPadding,
      this.valueField = KenRadioButtonsModel.defaultValueField,
      this.displayedField = KenRadioButtonsModel.defaultDisplayedField,
      this.selectedValue,
      this.clientOnPressed(String value)?,
      this.columns = KenRadioButtonsModel.defaultColumns,
      this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenRadioButtonsModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenRadioButtonsModel m = model as KenRadioButtonsModel;
    id = m.id;
    type = m.type;
    title = m.title;
    backColor = m.backColor;
    width = m.width;
    height = m.height;
    align = m.align;
    fontColor = m.fontColor;
    fontSize = m.fontSize;
    padding = m.padding;
    valueField = m.valueField;
    displayedField = m.displayedField;
    selectedValue = m.selectedValue;
    columns = m.columns;
    radioButtonColor = m.radioButtonColor;
    fontBold = m.fontBold;
    captionBackColor = m.captionBackColor;
    captionFontBold = m.captionFontBold;
    captionFontColor = m.captionFontColor;
    captionFontSize = m.captionFontSize;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenRadioButtonsModel m = model as KenRadioButtonsModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<dynamic>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'code': element[m.valueField].toString(),
          'value': element[m.displayedField].toString()
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _KenRadioButtonsState createState() => _KenRadioButtonsState();
}

class _KenRadioButtonsState extends State<KenRadioButtons>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  dynamic _data;
  KenRadioButtonsModel? _model;

  @override
  void initState() {
    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.initState, null, null);
    }

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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radioButtons = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return radioButtons;
  }

  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    var buttons = List<Widget>.empty(growable: true);

    int buttonIndex = 0;
    double? radioHeight = widget.height;
    double? radioWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (radioHeight == 0)
        radioHeight = (_model!.parent as KenSectionModel).height;
      if (radioWidth == 0)
        radioWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (radioHeight == 0)
        radioHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (radioWidth == 0) radioWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    _data.forEach((radioButtonData) {
      buttonIndex += 1;

      final button = KenRadioButton(
          id: '${KenUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
          type: widget.type,
          title: widget.title,
          data: radioButtonData,
          backColor: widget.backColor,
          width: radioWidth,
          height: radioHeight,
          align: widget.align,
          fontColor: widget.fontColor,
          fontSize: widget.fontSize,
          padding: widget.padding,
          valueField: widget.valueField,
          displayedField: widget.displayedField,
          radioButtonColor: widget.radioButtonColor,
          selectedValue: widget.selectedValue,
          icon: null, // così anche in originale
          onPressed: (value) {
            if (widget.callBack != null) {
              widget.callBack!(
                widget,
                KenCallbackType.onPressed,
                value,
                _data,
              );
            }
          });

      if (widget.callBack != null) {
        widget.callBack!(widget, KenCallbackType.getChildren, null, null);
      }
      buttons.add(button);
    });

    if (buttons.length > 0) {
      for (var i = 0; i < buttons.length; i++) {
        if (buttons[i] is KenRadioButton) {
          var others = List<KenRadioButton>.empty(growable: true);
          for (var k = 0; k < buttons.length; k++) {
            if (i != k && buttons[k] is KenRadioButton) {
              others.add(buttons[k] as KenRadioButton);
            }
          }
          (buttons[i] as KenRadioButton).others = others;
        }
      }

      double childAspectRatio = 0;
      childAspectRatio =
          (radioWidth! / radioHeight! * buttons.length * 3) / widget.columns!;

      TextStyle captionStyle = _getCaptionStile();

      var title = Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title!.isNotEmpty ? widget.title! : '',
            style: captionStyle,
          ));

      final container = Container(
          padding: widget.padding,
          child: Column(
            children: [
              title,
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: childAspectRatio,
                crossAxisCount: widget.columns!,
                children: buttons,
              )
            ],
          ));

      if (widget.callBack != null) {
        widget.callBack!(widget, KenCallbackType.selData, _data, null);
      }

      return KenWidgetBuilderResponse(_model, container);
    } else {
      KenLogService.writeDebugMessage(
          'Error SmeupRadioButtons no children \'radio button\' created',
          logType: KenLogType.error);
      return KenWidgetBuilderResponse(_model, KenNotAvailable());
    }
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

import 'dart:async';

import 'package:flutter/material.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_image_list_model.dart';
import '../models/widgets/ken_list_box_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenListBox.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenImageList extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenImageListModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? title;
  int? columns;
  int? rows;
  String? id;
  String? type;
  bool dismissEnabled = false;
  dynamic data;
  bool? showLoader = false;
  Axis? orientation;
  double? listHeight;

  // dynamisms functions
  Function? clientOnItemTap;

  dynamic parentForm;

  KenImageList.withController(
    KenImageListModel this.model,
    this.scaffoldKey,
    this.formKey,
    this.parentForm,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenImageList(
    this.scaffoldKey,
    this.formKey,
    this.data,
    this.columns,
    this.rows, {
    this.id = '',
    this.type = 'IML',
    this.backColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.width = KenImageListModel.defaultWidth,
    this.height = KenImageListModel.defaultHeight,
    this.padding = KenImageListModel.defaultPadding,
    this.orientation = KenImageListModel.defaultOrientation,
    this.listHeight = KenImageListModel.defaultListHeight,
    this.title = '',
    showLoader = false,
    this.clientOnItemTap,
    this.dismissEnabled = false,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenImageListModel m = model as KenImageListModel;
    id = m.id;
    type = m.type;
    width = m.width;
    height = m.height;
    fontSize = m.fontSize;
    fontColor = m.fontColor;
    fontBold = m.fontBold;
    backColor = m.backColor;
    captionFontBold = m.captionFontBold;
    captionFontSize = m.captionFontSize;
    captionFontColor = m.captionFontColor;
    padding = m.padding;
    columns = m.columns;
    rows = m.rows;
    title = m.title;
    showLoader = m.showLoader;
    orientation = m.orientation;
    listHeight = m.listHeight;

    int no = m.dynamisms.where((element) => element.event == 'delete').length;

    if (no > 0) {
      dismissEnabled = true;
    } else {
      dismissEnabled = false;
    }

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    // change data format
    // set the widget data
    return formatDataFields(model);
  }

  @override
  KenImageListState createState() => KenImageListState();
}

class KenImageListState extends State<KenImageList>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  List<Widget>? cells;
  KenImageListModel? _model;
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var listbox = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return listbox;
  }

  /// Label's structure:
  /// define the structure ...
  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await _model!.getData();
        // await SmeupListBoxDao.getData(_model!);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    Widget? children;

    int? noColl = widget.columns;
    if (noColl == 0) {
      noColl = widget.rows;
    }

    if (noColl == null || noColl == 0) {
      return getFunErrorResponse(context, _model);
    }

    double? listboxHeight =
        KenListBox.getListHeight(widget.listHeight, _model, context);

    if (_model == null) {
      children = KenListBox(
        widget.scaffoldKey,
        widget.formKey,
        _data,
        clientOnItemTap: widget.clientOnItemTap,
        dismissEnabled: widget.dismissEnabled,
        borderColor: widget.borderColor,
        borderWidth: widget.borderWidth,
        borderRadius: widget.borderRadius,
        backColor: widget.backColor,
        fontSize: widget.captionFontSize,
        fontColor: widget.captionFontColor,
        fontBold: widget.fontBold,
        captionFontBold: widget.captionFontBold,
        captionFontSize: widget.captionFontSize,
        captionFontColor: widget.captionFontColor,
        height: widget.height,
        listHeight: listboxHeight,
        layout: 'imageList',
        listType: KenListType.oriented,
        orientation: widget.orientation,
        padding: widget.padding,
        portraitColumns: noColl,
        landscapeColumns: noColl,
        width: widget.width,
        showLoader: widget.showLoader,
        title: widget.title,
      );
    } else {
      final _modelListBox = KenListBoxModel(
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          borderRadius: widget.borderRadius,
          backColor: widget.backColor,
          fontSize: widget.captionFontSize,
          fontColor: widget.captionFontColor,
          fontBold: widget.fontBold,
          captionFontBold: widget.captionFontBold,
          captionFontSize: widget.captionFontSize,
          captionFontColor: widget.captionFontColor,
          height: widget.height,
          listHeight: listboxHeight,
          layout: 'imageList',
          listType: KenListType.oriented,
          orientation: widget.orientation,
          padding: widget.padding,
          portraitColumns: noColl,
          landscapeColumns: noColl,
          width: widget.width,
          title: widget.title,
          formKey: widget.formKey);
      _modelListBox.dynamisms = _model!.dynamisms;
      _modelListBox.data = _data;

      Completer<dynamic> completer = Completer();
      KenMessageBus.instance
          .response(
              id: widget.globallyUniqueId,
              topic: KenTopic.kenImageListGetChildren)
          .take(1)
          .listen((event) {
        children = event.data.data;
        completer.complete(); // resolve promise
      });

      KenMessageBus.instance.publishRequest(
        widget.globallyUniqueId,
        KenTopic.kenImageListGetChildren,
        KenMessageBusEventData(
            context: context,
            widget: widget,
            model: _modelListBox,
            data: _data),
      );

      await completer.future;
    }

    return KenWidgetBuilderResponse(_model, children);
  }
}

import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_list_box_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_image_list_model.dart';
import 'package:ken/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_list_box.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupImageList extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupImageListModel? model;
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

  SmeupImageList.withController(SmeupImageListModel this.model,
      this.scaffoldKey, this.formKey, this.parentForm)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupImageList(
      this.scaffoldKey, this.formKey, this.data, this.columns, this.rows,
      {this.id = '',
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
      this.width = SmeupImageListModel.defaultWidth,
      this.height = SmeupImageListModel.defaultHeight,
      this.padding = SmeupImageListModel.defaultPadding,
      this.orientation = SmeupImageListModel.defaultOrientation,
      this.listHeight = SmeupImageListModel.defaultListHeight,
      this.title = '',
      showLoader: false,
      this.clientOnItemTap,
      this.dismissEnabled = false})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupImageListModel m = model as SmeupImageListModel;
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
  dynamic treatData(SmeupModel model) {
    // change data format
    // set the widget data
    return formatDataFields(model);
  }

  @override
  _SmeupImageListState createState() => _SmeupImageListState();
}

class _SmeupImageListState extends State<SmeupImageList>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  List<Widget>? cells;
  SmeupImageListModel? _model;
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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupListBoxDao.getData(_model!);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    Widget children;

    int? noColl = widget.columns;
    if (noColl == 0) {
      noColl = widget.rows;
    }

    if (noColl == null || noColl == 0) {
      return getFunErrorResponse(context, _model);
    }

    double? listboxHeight =
        SmeupListBox.getListHeight(widget.listHeight, _model, context);

    if (_model == null) {
      children = SmeupListBox(widget.scaffoldKey, widget.formKey, _data,
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
          listType: SmeupListType.oriented,
          orientation: widget.orientation,
          padding: widget.padding,
          portraitColumns: noColl,
          landscapeColumns: noColl,
          width: widget.width,
          showLoader: widget.showLoader,
          title: widget.title);
    } else {
      final _modelListBox = SmeupListBoxModel(
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
          listType: SmeupListType.oriented,
          orientation: widget.orientation,
          padding: widget.padding,
          portraitColumns: noColl,
          landscapeColumns: noColl,
          width: widget.width,
          title: widget.title,
          formKey: widget.formKey);
      _modelListBox.dynamisms = _model!.dynamisms;
      _modelListBox.data = _data;
      children = SmeupListBox.withController(
          _modelListBox, widget.scaffoldKey, widget.formKey, widget.parentForm);
    }

    return SmeupWidgetBuilderResponse(_model, children);
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_image_list_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_list_box.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupImageList extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupImageListModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  // graphic properties
  double width;
  double height;
  double listHeight;
  Axis orientation;
  EdgeInsetsGeometry padding;
  SmeupListType listType;
  String layout;
  String title;
  int portraitColumns;
  int landscapeColumns;
  String id;
  String type;
  bool dismissEnabled = false;
  double fontsize;
  dynamic data;
  bool showLoader = false;

  // dynamisms functions
  Function clientOnItemTap;

  SmeupImageList.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupImageList(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'IML',
      layout,
      this.width = SmeupImageListModel.defaultWidth,
      this.height = SmeupImageListModel.defaultHeight,
      this.listHeight = SmeupImageListModel.defaultHeight,
      this.fontsize = SmeupImageListModel.defaultFontsize,
      this.orientation = SmeupImageListModel.defaultOrientation,
      this.padding = SmeupImageListModel.defaultPadding,
      this.listType = SmeupImageListModel.defaultListType,
      this.portraitColumns = SmeupImageListModel.defaultPortraitColumns,
      this.landscapeColumns = SmeupImageListModel.defaultLandscapeColumns,
      title = '',
      showLoader: false,
      this.clientOnItemTap,
      this.dismissEnabled = false})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupImageListModel m = model;
    id = m.id;
    type = m.type;
    layout = m.layout;
    width = m.width;
    height = m.height;
    listHeight = m.listHeight;
    fontsize = m.fontsize;
    orientation = m.orientation;
    padding = m.padding;
    listType = m.listType;
    portraitColumns = m.portraitColumns;
    landscapeColumns = m.landscapeColumns;
    title = m.title;
    showLoader = m.showLoader;

    dynamic deleteDynamism;
    if (m.dynamisms != null)
      deleteDynamism = (m.dynamisms as List<dynamic>).firstWhere(
          (element) => element['event'] == 'delete',
          orElse: () => null);

    if (deleteDynamism != null) {
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
  List<Widget> cells;
  SmeupImageListModel _model;
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
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupListBoxDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    Widget children;

    if (_model == null) {
      children = SmeupListBox(widget.scaffoldKey, widget.formKey, _data,
          clientOnItemTap: widget.clientOnItemTap,
          dismissEnabled: widget.dismissEnabled,
          fontsize: widget.fontsize,
          height: widget.height,
          landscapeColumns: widget.landscapeColumns,
          layout: 'imageList',
          listHeight: widget.listHeight,
          listType: SmeupListType.oriented,
          orientation: widget.orientation,
          padding: widget.padding,
          portraitColumns: widget.portraitColumns,
          width: widget.width,
          showLoader: widget.showLoader,
          title: widget.title);
    } else {
      final _modelListBox = SmeupListBoxModel(
          fontsize: widget.fontsize,
          height: widget.height,
          landscapeColumns: widget.landscapeColumns,
          layout: 'imageList',
          listHeight: widget.listHeight,
          listType: SmeupListType.oriented,
          orientation: widget.orientation,
          padding: widget.padding,
          portraitColumns: widget.portraitColumns,
          width: widget.width,
          title: widget.title,
          formKey: widget.formKey);
      _modelListBox.dynamisms = _model.dynamisms;
      _modelListBox.data = _data;
      children = SmeupListBox.withController(
          _modelListBox, widget.scaffoldKey, widget.formKey);
    }

    return SmeupWidgetBuilderResponse(_model, children);
  }
}

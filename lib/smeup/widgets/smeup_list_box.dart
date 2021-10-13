import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_box.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupListBox extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupListBoxModel model;
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
  List<String> columns = new List<String>.empty(growable: true);

  // dynamisms functions
  Function clientOnItemTap;

  SmeupListBox.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupListBox(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'BOX',
      this.layout,
      this.width = SmeupListBoxModel.defaultWidth,
      this.height = SmeupListBoxModel.defaultHeight,
      this.listHeight = SmeupListBoxModel.defaultHeight,
      this.fontsize = SmeupListBoxModel.defaultFontsize,
      this.orientation = SmeupListBoxModel.defaultOrientation,
      this.padding = SmeupListBoxModel.defaultPadding,
      this.listType = SmeupListBoxModel.defaultListType,
      this.portraitColumns = SmeupListBoxModel.defaultPortraitColumns,
      this.landscapeColumns = SmeupListBoxModel.defaultLandscapeColumns,
      this.columns,
      title = '',
      showLoader: false,
      this.clientOnItemTap,
      this.dismissEnabled = false})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupListBoxModel m = model;
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
    columns = m.columns;
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
  _SmeupListBoxState createState() => _SmeupListBoxState();
}

class _SmeupListBoxState extends State<SmeupListBox>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  List<Widget> cells;
  SmeupListBoxModel _model;
  dynamic _data;

  final _scrollController = FixedExtentScrollController();

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

    cells = _getCells();
    if (cells == null) {
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    switch (widget.listType) {
      case SmeupListType.simple:
        children = _getSimpleList(cells);
        break;
      case SmeupListType.oriented:
        children = _getOrientedList(cells);
        break;
      case SmeupListType.wheel:
        children = _getWheelList(cells);
        break;
      default:
    }

    return SmeupWidgetBuilderResponse(_model, children);
  }

  Widget _getSimpleList(List<Widget> cells) {
    var list = RefreshIndicator(
      onRefresh: _refreshList,
      child: ListView.builder(
        scrollDirection: widget.orientation,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: cells.length,
        itemBuilder: (context, index) {
          return cells[index];
        },
      ),
    );

    double listboxHeight = widget.height;
    double listboxWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (listboxHeight == 0)
        listboxHeight = (_model.parent as SmeupSectionModel).height;
      if (listboxWidth == 0)
        listboxWidth = (_model.parent as SmeupSectionModel).width;
    }

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: listboxHeight,
        child: list);

    return container;
  }

  Widget _getOrientedList(List<Widget> cells) {
    var list;

    MediaQueryData deviceInfo = MediaQuery.of(context);

    list = OrientationBuilder(
      builder: (context, orientation) {
        int col = widget.portraitColumns;
        if (orientation == Orientation.landscape) {
          col = widget.landscapeColumns;
        }

        double childAspectRatio = 0;
        double boxHeight = 0;

        if (cells.length > 0)
          boxHeight = (cells[0] as SmeupBox).height;
        else
          boxHeight = 1;

        childAspectRatio = deviceInfo.size.width / (boxHeight * (col * 5 / 5));
        // 500;

        return RefreshIndicator(
          onRefresh: _refreshList,
          child: GridView.count(
            childAspectRatio: childAspectRatio,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: widget.orientation,
            crossAxisCount: col,
            children: cells,
          ),
        );
      },
    );

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height:
            widget.listHeight == 0 ? deviceInfo.size.height : widget.listHeight,
        child: list);

    return container;
  }

  Widget _getWheelList(List<Widget> cells) {
    var list;

    MediaQueryData deviceInfo = MediaQuery.of(context);

    list = RefreshIndicator(
        onRefresh: _refreshList,
        child: ClickableListWheelScrollView(
            scrollController: _scrollController,
            itemHeight: widget.height,
            itemCount: cells.length,
            onItemTapCallback: (index) {
              // if (widget.clientOnItemTap != null) {
              //   widget.clientOnItemTap();
              // } else {
              (cells[index] as SmeupBox).onItemTap();
              //}
            },
            child: ListWheelScrollView.useDelegate(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _scrollController,
              itemExtent: widget.height,
              onSelectedItemChanged: (index) {
                print("onSelectedItemChanged index: $index");
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) => cells[index],
                childCount: cells.length,
              ),
            )));

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height:
            widget.listHeight == 0 ? deviceInfo.size.height : widget.listHeight,
        child: list);

    return container;
  }

  Future<void> _refreshList() async {
    setDataLoad(widget.id, false);
    setState(() {});
  }

  List<Widget> _getCells() {
    final cells = List<Widget>.empty(growable: true);

    _data['rows'].forEach((dataElement) {
      final cell = SmeupBox(widget.scaffoldKey, widget.formKey,
          onRefresh: _refreshList,
          showLoader: widget.showLoader,
          id: widget.id,
          layout: widget.layout,
          columns: _data['columns'],
          visibleColumns: widget.columns,
          data: dataElement,
          dynamisms: _model?.dynamisms,
          height: widget.height,
          width: widget.width,
          dismissEnabled: widget.dismissEnabled, onItemTap: (dynamic data) {
        if (widget.clientOnItemTap != null) widget.clientOnItemTap(data);
        SmeupDynamismService.storeDynamicVariables(data, widget.formKey);
        if (_model != null)
          SmeupDynamismService.run(_model.dynamisms, context, 'click',
              widget.scaffoldKey, widget.formKey);
      });

      cells.add(cell);
    });

    return cells;
  }
}

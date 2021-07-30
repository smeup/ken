import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
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
  double padding;
  double paddingRight;
  double paddingLeft;
  SmeupListType listType;
  String layout;
  String title;
  int portraitColumns;
  int landscapeColumns;

  // dynamisms functions
  //Function onServerPressed;
  Function onClientPressed;

  SmeupListBox.withController(this.model, this.scaffoldKey, this.formKey) {
    runControllerActivities(model);
  }

  SmeupListBox(this.scaffoldKey, this.formKey,
      {
      //   this.portraitColumns,
      // this.landscapeColumns,
      layout,
      this.width = SmeupListBoxModel.defaultWidth,
      this.height = SmeupListBoxModel.defaultHeight,
      this.listHeight = SmeupListBoxModel.defaultHeight,
      this.orientation,
      this.padding = SmeupListBoxModel.defaultPadding,
      this.paddingRight = SmeupListBoxModel.defaultPadding,
      this.paddingLeft = SmeupListBoxModel.defaultPadding,
      this.listType = SmeupListBoxModel.defaultListType,
      this.portraitColumns = SmeupListBoxModel.defaultPortraitColumns,
      this.landscapeColumns = SmeupListBoxModel.defaultLandscapeColumns,
      title = '',
      //this.onServerPressed,
      this.onClientPressed}) {
    this.model = SmeupListBoxModel(
        layout: layout,
        width: width,
        height: height,
        listHeight: listHeight,
        orientation: orientation,
        padding: padding,
        paddingRight: paddingRight,
        paddingLeft: paddingLeft,
        listType: listType,
        portraitColumns: portraitColumns,
        landscapeColumns: landscapeColumns,
        title: title);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupListBoxModel m = model;

    layout = m.layout;
    width = m.width;
    height = m.height;
    listHeight = m.listHeight;
    orientation = m.orientation;
    padding = m.padding;
    paddingRight = m.paddingRight;
    paddingLeft = m.paddingLeft;
    listType = m.listType;
    portraitColumns = m.portraitColumns;
    landscapeColumns = m.landscapeColumns;
    title = m.title;
  }

  @override
  _SmeupListBoxState createState() => _SmeupListBoxState();
}

class _SmeupListBoxState extends State<SmeupListBox>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  List<Widget> cells;
  SmeupListBoxModel _model;
  final _scrollController = FixedExtentScrollController();

  @override
  void initState() {
    _model = widget.model;
    widgetLoadType = _model.widgetLoadType;
    dataLoaded = _model.dataLoaded;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, _model.id);
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
    var listbox = runBuild(context, _model.id, _model.type, widget.scaffoldKey,
        notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        dataLoaded = false;
      });
    });

    return listbox;
  }

  /// Label's structure:
  /// define the structure ...
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!dataLoaded && widgetLoadType != LoadType.Delay) {
      _model.data = await SmeupListBoxDao.getData(_model);
      dataLoaded = true;
    }

    if (!hasData(_model)) {
      return getFunErrorResponse(context, _model);
    }

    Widget children;

    cells = _getCells();
    if (cells == null) {
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    var padding = EdgeInsets.zero;
    if (widget.padding > 0) padding = EdgeInsets.all(widget.padding);
    if (widget.paddingRight > 0 || widget.paddingLeft > 0)
      padding =
          EdgeInsets.only(right: widget.paddingRight, left: widget.paddingLeft);

    switch (widget.listType) {
      case SmeupListType.simple:
        children = _getSimpleList(cells, padding);
        break;
      case SmeupListType.oriented:
        children = _getOrientedList(cells, padding);
        break;
      case SmeupListType.wheel:
        children = _getWheelList(cells, padding);
        break;
      default:
    }

    return SmeupWidgetBuilderResponse(_model, children);
  }

  Widget _getSimpleList(List<Widget> cells, EdgeInsets padding) {
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

    final container = Container(
        padding: padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

    return container;
  }

  Widget _getOrientedList(List<Widget> cells, EdgeInsets padding) {
    var list;

    double childAspectRatio =
        widget.height == 0 ? 9 : SmeupOptions.deviceHeight / widget.height;

    list = OrientationBuilder(
      builder: (context, orientation) {
        int col = widget.portraitColumns;
        if (SmeupOptions.orientation == Orientation.landscape) {
          col = widget.landscapeColumns;
        }
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
        padding: padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

    return container;
  }

  Widget _getWheelList(List<Widget> cells, EdgeInsets padding) {
    var list;
    // if (widget.listBoxModel.orientation == Axis.vertical) {

    // } else {

    // }
    list = ClickableListWheelScrollView(
        scrollController: _scrollController,
        itemHeight: widget.height,
        itemCount: cells.length,
        onItemTapCallback: (index) {
          //print("onItemTapCallback index: $index");
          if (widget.onClientPressed != null) {
            widget.onClientPressed();
          } else {
            //widget.onServerPressed();
            (cells[index] as SmeupBox).onServerPressed();
          }
        },
        child: ListWheelScrollView.useDelegate(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _scrollController,
          itemExtent: widget.height,
          //physics: FixedExtentScrollPhysics(),
          //overAndUnderCenterOpacity: 0.5,
          //perspective: 0.002,
          onSelectedItemChanged: (index) {
            print("onSelectedItemChanged index: $index");
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => cells[index],
            childCount: cells.length,
          ),
        ));

    final container = Container(
        padding: padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

    return container;
  }

  Future<void> _refreshList() async {
    setState(() {});
  }

  List<Widget> _getCells() {
    final cells = List<Widget>.empty(growable: true);

    _model.data['rows'].forEach((dataElement) {
      var boxModel = SmeupBoxModel(
          layout: widget.layout,
          columns: _model.data['columns'],
          height: widget.height,
          width: widget.width,
          title: widget.title,
          clientRow: dataElement);

      // final container = Container(
      //     padding: const EdgeInsets.all(5.0),
      //     color: Colors.transparent,
      //     height: widget.height == 0 ? double.infinity : widget.height,
      //     width: widget.width == 0 ? double.infinity : widget.width,
      //     child: SmeupBox(_model, boxModel, _refreshList, widget.scaffoldKey,
      //         widget.formKey, onClientPressed: widget.onClientPressed,
      //         onServerPressed: () {
      //       SmeupDynamismService.storeDynamicVariables(boxModel.data);
      //       SmeupDynamismService.run(
      //           _model.dynamisms, context, 'click', widget.scaffoldKey);
      //     }));
      final cell = SmeupBox(
          _model, boxModel, _refreshList, widget.scaffoldKey, widget.formKey,
          onClientPressed: widget.onClientPressed, onServerPressed: () {
        SmeupDynamismService.storeDynamicVariables(boxModel.data);
        SmeupDynamismService.run(
            _model.dynamisms, context, 'click', widget.scaffoldKey);
      });

      cells.add(cell);
    });

    return cells;
  }
}

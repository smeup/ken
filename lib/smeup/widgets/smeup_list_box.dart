import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
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

  Color backColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double fontSize;
  Color fontColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;

  double width;
  double height;
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
  dynamic data;
  bool showLoader = false;
  String defaultSort;
  String backgroundColName;
  bool showSelection = false;
  int selectedRow = -1;
  double listHeight;

  // dynamisms functions
  Function clientOnItemTap;

  SmeupListBox.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupListBox(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'BOX',
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.backColor,
      this.fontSize,
      this.fontColor,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.layout = SmeupListBoxModel.defaultLayout,
      this.width = SmeupListBoxModel.defaultWidth,
      this.height = SmeupListBoxModel.defaultHeight,
      this.orientation = SmeupListBoxModel.defaultOrientation,
      this.padding = SmeupListBoxModel.defaultPadding,
      this.listType = SmeupListBoxModel.defaultListType,
      this.portraitColumns = SmeupListBoxModel.defaultPortraitColumns,
      this.landscapeColumns = SmeupListBoxModel.defaultLandscapeColumns,
      this.backgroundColName = SmeupListBoxModel.defaultBackgroundColName,
      this.listHeight = SmeupListBoxModel.defaultListHeight,
      this.showSelection = false,
      this.selectedRow = -1,
      title = '',
      showLoader: false,
      this.clientOnItemTap,
      this.dismissEnabled = false,
      this.defaultSort = SmeupListBoxModel.defaultDefaultSort})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupListBoxModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupListBoxModel m = model;
    id = m.id;
    type = m.type;
    layout = m.layout;
    width = m.width;
    height = m.height;
    fontSize = m.fontSize;
    orientation = m.orientation;
    padding = m.padding;
    listType = m.listType;
    portraitColumns = m.portraitColumns;
    landscapeColumns = m.landscapeColumns;
    title = m.title;
    showLoader = m.showLoader;
    defaultSort = m.defaultSort;
    fontColor = m.fontColor;
    fontBold = m.fontBold;
    backColor = m.backColor;
    backgroundColName = m.backgroundColName;
    showSelection = m.showSelection;
    selectedRow = m.selectedRow;
    listHeight = m.listHeight;
    borderRadius = m.borderRadius;
    borderWidth = m.borderWidth;
    borderColor = m.borderColor;
    captionFontBold = m.captionFontBold;
    captionFontSize = m.captionFontSize;
    captionFontColor = m.captionFontColor;

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
    SmeupListBoxModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      // Manage columns setup field: hide column if isn't in the set of columns
      if (m.visibleColumns.isNotEmpty) {
        for (var i = 0; i < (workData['columns'] as List).length; i++) {
          final column = workData['columns'][i];
          if (m.visibleColumns.contains(column['code']) == false) {
            column['IO'] = 'H';
          }
        }
        return workData;
      } else {
        return workData;
      }
    } else {
      return model.data;
    }
  }

  static double getListHeight(
      double widgetListHeight, SmeupModel model, BuildContext context) {
    double listboxHeight = widgetListHeight;
    if (model != null && model.parent != null) {
      if (listboxHeight == 0)
        listboxHeight = (model.parent as SmeupSectionModel).height;
    } else {
      if (listboxHeight == 0)
        listboxHeight = MediaQuery.of(context).size.height;
    }
    return listboxHeight;
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

    double listboxHeight =
        SmeupListBox.getListHeight(widget.listHeight, _model, context);

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
    double boxHeight = 0;
    if (cells.length > 0)
      boxHeight = (cells[0] as SmeupBox).height;
    else
      boxHeight = 1;

    list = OrientationBuilder(
      builder: (context, orientation) {
        int col = widget.portraitColumns;
        if (orientation == Orientation.landscape) {
          col = widget.landscapeColumns;
        }

        double childAspectRatio = 0;
        childAspectRatio = deviceInfo.size.width / boxHeight * col;
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

    double listboxHeight =
        SmeupListBox.getListHeight(widget.listHeight, _model, context);

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: listboxHeight,
        child: list);

    return container;
  }

  Widget _getWheelList(List<Widget> cells) {
    var list;

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

    double listboxHeight =
        SmeupListBox.getListHeight(widget.listHeight, _model, context);

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: listboxHeight,
        child: list);

    return container;
  }

  Future<void> _refreshList() async {
    setDataLoad(widget.id, false);
    setState(() {});
  }

  List<Widget> _getCells() {
    final cells = List<Widget>.empty(growable: true);

    double boxHeight = widget.height;
    double boxWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (boxHeight == 0)
        boxHeight = (_model.parent as SmeupSectionModel).height;
      if (boxWidth == 0) boxWidth = (_model.parent as SmeupSectionModel).width;
    } else {
      if (boxHeight == 0) boxHeight = MediaQuery.of(context).size.height;
      if (boxWidth == 0) boxWidth = MediaQuery.of(context).size.width;
    }

    List _rows = _data['rows'];

    if (widget.defaultSort.isNotEmpty) {
      //Manage defaultSort setup parameter
      _rows.sort(
          (a, b) => (a[widget.defaultSort]).compareTo(b[widget.defaultSort]));
      _data['rows'] = _rows;
    }

    _data['rows'].asMap().forEach((i, dataElement) {
      var _backColor = widget.backColor;
      if (widget.backgroundColName != null &&
          widget.backgroundColName.isNotEmpty) {
        _backColor = SmeupUtilities.getColorFromRGB(
            dataElement[widget.backgroundColName]);
      }

      CardTheme cardTheme = _getCardStyle(_backColor);
      TextStyle textStyle = _getTextStile(_backColor);
      TextStyle captionStyle = _getCaptionStile(_backColor);

      Function _onItemTap = (int index, dynamic data) {
        if (widget.clientOnItemTap != null) widget.clientOnItemTap(data);
        SmeupDynamismService.storeDynamicVariables(data, widget.formKey);
        if (_model != null)
          SmeupDynamismService.run(_model.dynamisms, context, 'click',
              widget.scaffoldKey, widget.formKey);

        if (widget.showSelection && widget.selectedRow != index) {
          setState(() {
            widget.selectedRow = index;
          });
        }
      };

      final cell = SmeupBox(widget.scaffoldKey, widget.formKey, i,
          isDynamic: _model != null,
          selectedRow: widget.selectedRow,
          onRefresh: _refreshList,
          showLoader: widget.showLoader,
          id: widget.id,
          layout: widget.layout,
          columns: _data['columns'],
          data: dataElement,
          dynamisms: _model?.dynamisms,
          height: widget.height,
          width: widget.width,
          fontColor: widget.fontColor,
          backColor: _backColor,
          showSelection: widget.showSelection,
          dismissEnabled: widget.dismissEnabled,
          onItemTap: _onItemTap,
          cardTheme: cardTheme,
          textStyle: textStyle,
          captionStyle: captionStyle);

      cells.add(cell);
    });

    return cells;
  }

  CardTheme _getCardStyle(Color backColor) {
    var timeCardTheme = SmeupConfigurationService.getTheme().cardTheme.copyWith(
          color: backColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: BorderSide(
                  width: widget.borderWidth, color: widget.borderColor)),
        );

    return timeCardTheme;
  }

  TextStyle _getTextStile(Color backColor) {
    TextStyle style =
        SmeupConfigurationService.getTheme().textTheme.copyWith().headline1;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: backColor);

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile(Color backColor) {
    TextStyle style =
        SmeupConfigurationService.getTheme().textTheme.copyWith().headline2;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: backColor);

    if (widget.captionFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}

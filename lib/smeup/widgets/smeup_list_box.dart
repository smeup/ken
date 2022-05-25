import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_list_box_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_box.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupListBox extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupListBoxModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  dynamic parentForm;

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
  Axis? orientation;
  EdgeInsetsGeometry? padding;
  SmeupListType? listType;
  String? layout;
  String? title;
  int? portraitColumns;
  int? landscapeColumns;
  String? id;
  String? type;
  bool dismissEnabled = false;
  dynamic data;
  bool? showLoader = false;
  String? defaultSort;
  String? backgroundColName;
  bool? showSelection = false;
  int? selectedRow = -1;
  double? listHeight;

  // dynamisms functions
  Function? clientOnItemTap;

  SmeupListBox.withController(SmeupListBoxModel this.model, this.scaffoldKey,
      this.formKey, this.parentForm)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
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
    SmeupListBoxModel m = model as SmeupListBoxModel;
    id = m.id;
    type = m.type;
    layout = m.layout;
    width = m.width;
    height = m.height;
    orientation = m.orientation;
    padding = m.padding;
    listType = m.listType;
    portraitColumns = m.portraitColumns;
    landscapeColumns = m.landscapeColumns;
    title = m.title;
    showLoader = m.showLoader;
    defaultSort = m.defaultSort;
    fontSize = m.fontSize;
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
    SmeupListBoxModel m = model as SmeupListBoxModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      // Manage columns setup field: hide column if isn't in the set of columns
      if (m.visibleColumns!.isNotEmpty) {
        for (var i = 0; i < (workData['columns'] as List).length; i++) {
          final column = workData['columns'][i];
          if (m.visibleColumns!.contains(column['code']) == false) {
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

  static double? getListHeight(
      double? widgetListHeight, SmeupModel? model, BuildContext context) {
    double? listboxHeight = widgetListHeight;
    if (model != null && model.parent != null) {
      if (listboxHeight == 0)
        listboxHeight = (model.parent as SmeupSectionModel).height;
    } else {
      if (listboxHeight == 0)
        listboxHeight = SmeupUtilities.getDeviceInfo().safeHeight;
    }
    return listboxHeight;
  }

  @override
  _SmeupListBoxState createState() => _SmeupListBoxState();
}

class _SmeupListBoxState extends State<SmeupListBox>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  List<Widget>? cells;
  SmeupListBoxModel? _model;
  dynamic _data;
  ScrollController? _scrollController;
  int? _selectedRow = -1;
  bool _executeBouncing = false;
  Orientation? _orientation;
  Orientation? _oldOrientation;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    _selectedRow = widget.selectedRow;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    _scrollController = new ScrollController();

    String? localSelectedRow = SmeupConfigurationService.getLocalStorage()!
        .getString('${widget.formKey.hashCode}_${widget.id}');
    if (localSelectedRow != null && localSelectedRow.isNotEmpty) {
      _selectedRow = int.tryParse(localSelectedRow) ?? widget.selectedRow;
    }

    //_executeBouncing = true;

    super.initState();
  }

  void _runAutomaticScroll() {
    Future.delayed(Duration(milliseconds: 80), () async {
      double? realBoxHeight = SmeupConfigurationService.getLocalStorage()!
          .getDouble('${widget.formKey.hashCode}_${widget.id}_realBoxHeight');

      if (widget.listType == SmeupListType.oriented &&
          _selectedRow != -1 &&
          realBoxHeight != null &&
          _model != null) {
        if (_orientation != null) {
          int colsNumber = _orientation == Orientation.landscape
              ? _model!.landscapeColumns!
              : _model!.portraitColumns!;
          double? formSpace = SmeupUtilities.getDeviceInfo().safeHeight;

          if (_model != null && _model!.parent != null) {
            formSpace = (_model!.parent as SmeupSectionModel).height;
          }

          double scrollPosition =
              ((_selectedRow! + 1) * realBoxHeight / colsNumber);
          if (scrollPosition > formSpace!) {
            if (_scrollController!.positions.isNotEmpty) {
              _scrollController!.animateTo(scrollPosition,
                  duration: Duration(milliseconds: 80),
                  curve: Curves.bounceInOut);
            }
          }
        }
      }
    });
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

    _orientation = MediaQuery.of(context).orientation;

    Widget? children;

    cells = _getCells();
    if (cells == null) {
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    switch (widget.listType) {
      case SmeupListType.simple:
        children = _getSimpleList(cells!);
        break;
      case SmeupListType.oriented:
        children = _getOrientedList(cells!);
        break;
      case SmeupListType.wheel:
        children = _getWheelList(cells!);
        break;
      default:
    }

    _runAutomaticScroll();

    if (_oldOrientation != null &&
        _oldOrientation != _orientation &&
        widget.parentForm != null &&
        widget.parentForm.currentFormReload != null) {
      widget.parentForm.currentFormReload();
    }
    _oldOrientation = _orientation;

    return SmeupWidgetBuilderResponse(_model, children);
  }

  Widget _getSimpleList(List<Widget> cells) {
    var list = RefreshIndicator(
      onRefresh: _refreshList,
      child: ListView.builder(
        key: ObjectKey("_list_${widget.id}"),
        controller: _scrollController,
        scrollDirection: widget.orientation!,
        physics: _executeBouncing
            ? BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
            : null,
        itemCount: cells.length,
        itemBuilder: (context, index) {
          return cells[index];
        },
      ),
    );

    double? listboxHeight =
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

    double? boxHeight = 0;
    if (cells.length > 0)
      boxHeight = (cells[0] as SmeupBox).height;
    else
      boxHeight = 1;

    int? col = widget.portraitColumns;
    if (_orientation == Orientation.landscape) {
      col = widget.landscapeColumns;
    }

    double childAspectRatio = 0;
    childAspectRatio =
        SmeupUtilities.getDeviceInfo().safeWidth / boxHeight! * col!;

    list = RefreshIndicator(
      onRefresh: _refreshList,
      child: GridView.count(
        controller: _scrollController,
        childAspectRatio: childAspectRatio,
        physics: _executeBouncing
            ? BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
            : null,
        scrollDirection: widget.orientation!,
        crossAxisCount: col,
        children: cells,
      ),
    );

    double? listboxHeight =
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

    _scrollController = FixedExtentScrollController();
    list = RefreshIndicator(
        onRefresh: _refreshList,
        child: ClickableListWheelScrollView(
            scrollController: _scrollController!,
            itemHeight: widget.height!,
            itemCount: cells.length,
            onItemTapCallback: (index) {
              (cells[index] as SmeupBox).onItemTap!();
            },
            child: ListWheelScrollView.useDelegate(
              physics: _executeBouncing
                  ? BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics())
                  : null,
              controller: _scrollController,
              itemExtent: widget.height!,
              onSelectedItemChanged: (index) {
                print("onSelectedItemChanged index: $index");
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) => cells[index],
                childCount: cells.length,
              ),
            )));

    double? listboxHeight =
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

    double? boxHeight = widget.height;
    double? boxWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (boxHeight == 0)
        boxHeight = (_model!.parent as SmeupSectionModel).height;
      if (boxWidth == 0) boxWidth = (_model!.parent as SmeupSectionModel).width;
    } else {
      if (boxHeight == 0) boxHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      if (boxWidth == 0) boxWidth = SmeupUtilities.getDeviceInfo().safeWidth;
    }

    List? _rows = _data['rows'];

    if (widget.defaultSort!.isNotEmpty) {
      //Manage defaultSort setup parameter
      _rows!.sort(
          (a, b) => (a[widget.defaultSort]).compareTo(b[widget.defaultSort]));
      _data['rows'] = _rows;
    }

    _data['rows'].asMap().forEach((i, dataElement) {
      var _backColor = widget.backColor;
      if (widget.backgroundColName != null &&
          widget.backgroundColName!.isNotEmpty) {
        _backColor = SmeupUtilities.getColorFromRGB(
            dataElement[widget.backgroundColName]);
      }

      CardTheme cardTheme = _getCardStyle(_backColor);
      TextStyle textStyle = _getTextStile(_backColor);
      TextStyle captionStyle = _getCaptionStile(_backColor);

      Function _onItemTap = (int index, dynamic data) {
        if (widget.clientOnItemTap != null) widget.clientOnItemTap!(data);
        SmeupDynamismService.storeDynamicVariables(data, widget.formKey);
        if (_model != null)
          SmeupDynamismService.run(_model!.dynamisms, context, 'click',
              widget.scaffoldKey, widget.formKey);

        _selectedRow = index;

        SmeupConfigurationService.getLocalStorage()!.setString(
            '${widget.formKey.hashCode}_${widget.id}', _selectedRow.toString());

        if (widget.showSelection! && widget.selectedRow != index) {
          setState(() {
            //widget.selectedRow = index;
          });
        }
      };

      final cell = SmeupBox(
        widget.scaffoldKey,
        widget.formKey,
        i,
        isDynamic: _model != null,
        selectedRow: _selectedRow,
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
        captionStyle: captionStyle,
        onSizeChanged: onSizeChanged,
        isFirestore: _model == null ? false : _model!.isFirestore(),
      );

      cells.add(cell);
    });

    return cells;
  }

  void onSizeChanged(Size size) {
    SmeupConfigurationService.getLocalStorage()!.setDouble(
        '${widget.formKey.hashCode}_${widget.id}_realBoxHeight', size.height);
  }

  CardTheme _getCardStyle(Color? backColor) {
    var timeCardTheme =
        SmeupConfigurationService.getTheme()!.cardTheme.copyWith(
              color: backColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  side: BorderSide(
                      width: widget.borderWidth!, color: widget.borderColor!)),
            );

    return timeCardTheme;
  }

  TextStyle _getTextStile(Color? backColor) {
    TextStyle style =
        SmeupConfigurationService.getTheme()!.textTheme.headline4!;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: backColor);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile(Color? backColor) {
    TextStyle style =
        SmeupConfigurationService.getTheme()!.textTheme.headline5!;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: backColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}

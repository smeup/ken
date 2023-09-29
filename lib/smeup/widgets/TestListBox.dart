import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_list_box_model.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_section_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'TestBox.dart';
import 'kenNotAvailable.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class TestListBox extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenListBoxModel? model;
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
  KenListType? listType;
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
  String? localSelectedRow;
  double? realBoxHeight;

  // dynamisms functions
  Function? clientOnItemTap;

  TestListBox.withController(
    KenListBoxModel this.model,
    this.scaffoldKey,
    this.formKey,
    this.parentForm,
    this.localSelectedRow,
    this.realBoxHeight,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  TestListBox(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    this.id = '',
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
    this.layout = KenListBoxModel.defaultLayout,
    this.width = KenListBoxModel.defaultWidth,
    this.height = KenListBoxModel.defaultHeight,
    this.orientation = KenListBoxModel.defaultOrientation,
    this.padding = KenListBoxModel.defaultPadding,
    this.listType = KenListBoxModel.defaultListType,
    this.portraitColumns = KenListBoxModel.defaultPortraitColumns,
    this.landscapeColumns = KenListBoxModel.defaultLandscapeColumns,
    this.backgroundColName = KenListBoxModel.defaultBackgroundColName,
    this.listHeight = KenListBoxModel.defaultListHeight,
    this.showSelection = false,
    this.selectedRow = 0,
    this.localSelectedRow,
    this.realBoxHeight,
    title = '',
    showLoader = false,
    this.clientOnItemTap,
    this.dismissEnabled = false,
    this.defaultSort = KenListBoxModel.defaultDefaultSort,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    // KenListBoxModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenListBoxModel m = model as KenListBoxModel;
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
  dynamic treatData(KenModel model) {
    KenListBoxModel m = model as KenListBoxModel;

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
      double? widgetListHeight, KenModel? model, BuildContext context) {
    double? listboxHeight = widgetListHeight;
    if (model != null && model.parent != null) {
      if (listboxHeight == 0) {
        listboxHeight = (model.parent as KenSectionModel).height;
      }
    } else {
      if (listboxHeight == 0) {
        listboxHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
    }
    return listboxHeight;
  }

  @override
  _TestListBoxState createState() => _TestListBoxState();
}

class _TestListBoxState extends State<TestListBox>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  List<Widget>? cells;
  KenListBoxModel? _model;
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
    _scrollController = ScrollController();

    String? localSelectedRow = widget.localSelectedRow;

    if (localSelectedRow != null && localSelectedRow.isNotEmpty) {
      _selectedRow = int.tryParse(localSelectedRow) ?? widget.selectedRow;
    }
    //_executeBouncing = true;// così in originale

    super.initState();
  }

  void _runAutomaticScroll() {
    Future.delayed(const Duration(milliseconds: 80), () async {
      double? realBoxHeight = widget.realBoxHeight;

      if (widget.listType == KenListType.oriented &&
          _selectedRow != -1 &&
          realBoxHeight != null &&
          _model != null) {
        if (_orientation != null) {
          int colsNumber = _orientation == Orientation.landscape
              ? _model!.landscapeColumns!
              : _model!.portraitColumns!;
          double? formSpace = KenUtilities.getDeviceInfo().safeHeight;

          if (_model != null && _model!.parent != null) {
            formSpace = (_model!.parent as KenSectionModel).height;
          }

          double scrollPosition =
              ((_selectedRow! + 1) * realBoxHeight / colsNumber);
          if (scrollPosition > formSpace!) {
            if (_scrollController!.positions.isNotEmpty) {
              _scrollController!.animateTo(scrollPosition,
                  duration: const Duration(milliseconds: 80),
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupListBoxDao.getData(_model!);
        await _model!.getData();
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
      return KenWidgetBuilderResponse(_model, KenNotAvailable());
    }

    switch (widget.listType) {
      case KenListType.simple:
        children = _getSimpleList(cells!);
        break;
      case KenListType.oriented:
        children = _getOrientedList(cells!);
        break;
      case KenListType.wheel:
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

    return KenWidgetBuilderResponse(_model, children);
  }

  Widget _getSimpleList(List<Widget> cells) {
    var list = ListView.builder(
      key: ObjectKey("_list_${widget.id}"),
      controller: _scrollController,
      scrollDirection: widget.orientation!,
      physics: _executeBouncing
          ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
          : null,
      itemCount: cells.length,
      itemBuilder: (context, index) {
        return cells[index];
      },
    );

    double listboxheight = MediaQuery.of(context).size.height;

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: listboxheight,
        child: list);

    return container;
  }

  Widget _getOrientedList(List<Widget> cells) {
    double? boxHeight = widget.height;
    double? boxWidth = widget.width;

    if (cells.isNotEmpty) {
      boxHeight = (cells[0] as TestBox).height;
    } else {
      boxHeight = 1;
    }

    int? col = widget.portraitColumns;
    if (_orientation == Orientation.landscape) {
      col = widget.landscapeColumns;
    }

    double childAspectRatio = 0;
    childAspectRatio =
        KenUtilities.getDeviceInfo().safeWidth / boxHeight! * col!;

    final list = ListView.builder(
      key: ObjectKey("_list_${widget.id}"),
      controller: _scrollController,
      scrollDirection: widget.orientation!,
      physics: _executeBouncing
          ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
          : null,
      itemCount: cells.length,
      itemBuilder: (context, index) {
        return cells[index];
      },
    );

    final container = Expanded(
      child: Container(
        padding: widget.padding,
        color: Colors.transparent,
        child: list,
      ),
    );

    return container;
  }

  Widget _getWheelList(List<Widget> cells) {
    ClickableListWheelScrollView list;

    _scrollController = FixedExtentScrollController();
    list = ClickableListWheelScrollView(
        // RefreshIndicator(
        // onRefresh: _refreshList,
        // child: ClickableListWheelScrollView(
        scrollController: _scrollController!,
        itemHeight: widget.height!,
        itemCount: cells.length,
        onItemTapCallback: (index) {
          (cells[index] as TestBox).onItemTap!();
        },
        child: ListWheelScrollView.useDelegate(
          physics: _executeBouncing
              ? const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics())
              : null,
          controller: _scrollController,
          itemExtent: widget.height!,
          onSelectedItemChanged: (index) {
            //print("onSelectedItemChanged index: $index");
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => cells[index],
            childCount: cells.length,
          ),
        ));
    // );

    double? listboxHeight =
        TestListBox.getListHeight(widget.listHeight, _model, context);

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
      if (boxHeight == 0) {
        boxHeight = (_model!.parent as KenSectionModel).height;
      }
      if (boxWidth == 0) boxWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (boxHeight == 0) boxHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (boxWidth == 0) boxWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    List? _rows = _data['rows'];

    if (widget.defaultSort!.isNotEmpty) {
      //Manage defaultSort setup parameter
      _rows!.sort(
          (a, b) => (a[widget.defaultSort]).compareTo(b[widget.defaultSort]));
      _data['rows'] = _rows;
    }

    _data['rows'].asMap().forEach((i, dataElement) {
      // var _backColor = widget.backColor;
      var _backColor =
          (dataElement["disabled"] != null && dataElement["disabled"] as bool)
              ? Colors.grey[300]
              : widget.backColor;

      // if (widget.backgroundColName != null &&
      //     widget.backgroundColName!.isNotEmpty) {
      //   _backColor =
      //       KenUtilities.getColorFromRGB(dataElement[widget.backgroundColName]);
      // }

      TextStyle _getTextStile(Color? _backColor) {
        TextStyle style =
            KenConfigurationService.getTheme()!.textTheme.headline4!;

        if (dataElement["disabled"] != null &&
            dataElement["disabled"] as bool) {
          style = style.copyWith(
              color: Colors.grey[500],
              fontSize: widget.fontSize,
              backgroundColor:
                  _backColor); // se lo rimuovi rimane uno sfondo bianco, così prende il colore di sfondo
        } else {
          style = style.copyWith(
              color: widget.fontColor,
              fontSize: widget.fontSize,
              backgroundColor: Colors.transparent);
        }
        if (widget.fontBold!) {
          style = style.copyWith(
            fontWeight: FontWeight.w600,
          );
        }

        return style;
      }

      CardTheme _getCardStyle() {
        var timeCardTheme =
            KenConfigurationService.getTheme()!.cardTheme.copyWith(
                  color: widget.backColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius!),
                      side: BorderSide(
                          width: widget.borderWidth!,
                          color: dataElement["disabled"] != null &&
                                  dataElement["disabled"] as bool
                              ? Colors.grey
                              : widget.borderColor!)),
                );

        return timeCardTheme;
      }

      CardTheme cardTheme = _getCardStyle();
      TextStyle textStyle = _getTextStile(_backColor);
      TextStyle captionStyle = _getCaptionStile(_backColor);

      _onItemTap(int index, dynamic data, TestListBox listBox) {
        if (listBox.showSelection! && _selectedRow != index) {
          setState(() {
            //widget.selectedRow = index;// così in originale
          });
        }
        _selectedRow = index;

        KenMessageBus.instance.publishRequest(
          widget.globallyUniqueId + '_tap_' + index.toString(),
          KenTopic.kenlistboxOnItemTap,
          KenMessageBusEventData(
              context: context, widget: widget, model: _model, data: data),
        );
      }

      final cell = TestBox(widget.scaffoldKey, widget.formKey, i, widget,
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
          globallyUniqueId: widget.globallyUniqueId,
          onSizeChanged: onSizeChanged,
          isFirestore: _model == null ? false : _model!.isFirestore());

      cells.add(cell);
    });

    return cells;
  }

  void onSizeChanged(Size size) {
    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenlistboxOnSizeChange,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: size),
    );
  }

  TextStyle _getCaptionStile(Color? backColor) {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.headline5!;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: Colors.transparent);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }
}

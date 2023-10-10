import 'dart:ffi';

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';
import 'kenBox.dart';
import 'kenNotAvailable.dart';

enum KenListType { simple, oriented, wheel }

// ignore: must_be_immutable
class KenListBox extends StatefulWidget {
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

  double? availableSpace;
  Function? onRefresh;
  Function? onSizeChanged;

  Function? onItemTap;
  bool? isFirestore;
  Function? onDismissed;
  final Function? onGetBoxImage;
  final Function? onGetBoxText;

  KenListBox(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    this.id = '',
    this.type = 'BOX',
    this.borderColor = KenListBoxDefaults.defaultBorderColor,
    this.borderWidth = KenListBoxDefaults.defaultBorderRadius,
    this.borderRadius = KenListBoxDefaults.defaultBorderRadius,
    this.backColor = KenListBoxDefaults.defaultBackColor,
    this.fontSize = KenListBoxDefaults.defaultFontSize,
    this.fontColor = KenListBoxDefaults.defaultFontColor,
    this.fontBold = KenListBoxDefaults.defaultFontBold,
    this.captionFontBold = KenListBoxDefaults.defaultCaptionFontBold,
    this.captionFontSize = KenListBoxDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenListBoxDefaults.defaultCaptionFontColor,
    this.layout = KenListBoxDefaults.defaultLayout,
    this.width = KenListBoxDefaults.defaultWidth,
    this.height = KenListBoxDefaults.defaultHeight,
    this.orientation = KenListBoxDefaults.defaultOrientation,
    this.padding = KenListBoxDefaults.defaultPadding,
    this.listType = KenListBoxDefaults.defaultListType,
    this.portraitColumns = KenListBoxDefaults.defaultPortraitColumns,
    this.landscapeColumns = KenListBoxDefaults.defaultLandscapeColumns,
    this.backgroundColName = KenListBoxDefaults.defaultBackgroundColName,
    this.listHeight = KenListBoxDefaults.defaultListHeight,
    this.showSelection = false,
    this.selectedRow = 0,
    this.localSelectedRow,
    this.realBoxHeight = KenListBoxDefaults.defaultRealBoxHeight,
    title = '',
    showLoader = false,
    this.onItemTap,
    this.dismissEnabled = false,
    this.defaultSort = KenListBoxDefaults.defaultDefaultSort,
    this.availableSpace,
    this.onRefresh,
    this.isFirestore,
    this.onSizeChanged,
    this.onDismissed,
    this.onGetBoxImage,
    this.onGetBoxText,
  });

  @override
  KenListBoxState createState() => KenListBoxState();
}

class KenListBoxState extends State<KenListBox> {
  List<Widget>? cells;
  dynamic _data;
  ScrollController? _scrollController;
  int? _selectedRow = -1;
  final bool _executeBouncing = false;
  Orientation? _orientation;
  Orientation? _oldOrientation;
  double? _availableSpace;

  @override
  void initState() {
    _data = widget.data;
    _selectedRow = widget.selectedRow;
    _scrollController = ScrollController();
    _availableSpace =
        widget.availableSpace ?? KenUtilities.getDeviceInfo().safeHeight;

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
          realBoxHeight != null) {
        if (_orientation != null) {
          int colsNumber = _orientation == Orientation.landscape
              ? widget.landscapeColumns!
              : widget.portraitColumns!;

          double scrollPosition =
              ((_selectedRow! + 1) * realBoxHeight / colsNumber);
          if (scrollPosition > _availableSpace!) {
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
    _orientation = MediaQuery.of(context).orientation;

    cells = _getCells();
    if (cells == null) {
      return KenNotAvailable();
    }

    Widget children;
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
        return KenNotAvailable();
    }

    _runAutomaticScroll();

    if (_oldOrientation != null &&
        _oldOrientation != _orientation &&
        widget.parentForm != null &&
        widget.parentForm.currentFormReload != null) {
      widget.parentForm.currentFormReload();
    }
    _oldOrientation = _orientation;

    return children;
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

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

    return container;
  }

  Widget _getOrientedList(List<Widget> cells) {
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

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

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
          (cells[index] as KenBox).onItemTap!();
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

    final container = Container(
        padding: widget.padding,
        color: Colors.transparent,
        height: widget.listHeight,
        child: list);

    return container;
  }

  List<Widget> _getCells() {
    final cells = List<Widget>.empty(growable: true);

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

      TextStyle getTextStile(Color? backColor) {
        TextStyle style = TextStyle(fontSize: widget.fontSize);

        if (dataElement["disabled"] != null &&
            dataElement["disabled"] as bool) {
          style = style.copyWith(
              color: Colors.grey[500],
              fontSize: widget.fontSize,
              backgroundColor:
                  backColor); // se lo rimuovi rimane uno sfondo bianco, così prende il colore di sfondo
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
        } else {
          style = style.copyWith(
            fontWeight: FontWeight.normal,
          );
        }

        return style;
      }

      CardTheme getCardStyle() {
        var timeCardTheme = CardTheme(
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

      CardTheme cardTheme = getCardStyle();
      TextStyle textStyle = getTextStile(_backColor);
      TextStyle captionStyle = _getCaptionStile(_backColor);

      final cell = KenBox(
        widget.scaffoldKey,
        widget.formKey,
        i,
        widget,
        selectedRow: _selectedRow,
        onRefresh: widget.onRefresh,
        showLoader: widget.showLoader,
        id: widget.id,
        layout: widget.layout,
        columns: _data['columns'],
        data: dataElement,
        height: widget.height,
        width: widget.width,
        fontColor: widget.fontColor,
        backColor: _backColor,
        showSelection: widget.showSelection,
        dismissEnabled: widget.dismissEnabled,
        onItemTap: widget.onItemTap,
        cardTheme: cardTheme,
        textStyle: textStyle,
        captionStyle: captionStyle,
        onSizeChanged: widget.onSizeChanged,
        isFirestore: widget.isFirestore,
        onDismissed: widget.onDismissed,
        onGetBoxImage: widget.onGetBoxImage,
        onGetBoxText: widget.onGetBoxText,
      );

      cells.add(cell);
    });

    return cells;
  }

  TextStyle _getCaptionStile(Color? backColor) {
    TextStyle style = TextStyle(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: Colors.transparent);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }
}

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import '../managers/ken_configuration_manager.dart';
import '../services/ken_defaults.dart';
import 'ken_box.dart';
import 'ken_not_available.dart';

enum KenListType { simple, oriented, wheel }

class KenListBox extends StatefulWidget {
  final GlobalKey<ScaffoldState> formKey;

  final Color? backColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;

  final double? width;
  final double? height;
  final Axis? orientation;
  final EdgeInsetsGeometry? padding;
  final KenListType? listType;
  final String? layout;
  final String? title;
  final int? portraitColumns;
  final int? landscapeColumns;
  final String? id;
  final String? type;
  final bool dismissEnabled;
  final dynamic data;
  final bool? showLoader;
  final String? defaultSort;
  final String? backgroundColName;
  final bool? showSelection;
  final int? selectedRow;
  final double? listHeight;
  final String? storageSelectedRow;
  final double? realBoxHeight;

  final double? availableSpace;
  final Function? onRefresh;

  final bool? isFirestore;
  final Function? onGetBoxImage;
  final Function? onGetBoxText;
  final Function? onGetButtons;
  final Function? onGetButtonsColumns;

  const KenListBox(this.formKey, this.data,
      {super.key,
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
      this.showSelection = KenListBoxDefaults.defaultShowSelection,
      this.selectedRow = KenListBoxDefaults.defaultSelectedRow,
      this.storageSelectedRow,
      this.realBoxHeight = KenListBoxDefaults.defaultRealBoxHeight,
      this.dismissEnabled = false,
      this.defaultSort = KenListBoxDefaults.defaultDefaultSort,
      this.availableSpace,
      this.onRefresh,
      this.isFirestore,
      this.onGetBoxImage,
      this.onGetBoxText,
      this.onGetButtons,
      this.onGetButtonsColumns,
      this.title,
      this.showLoader});

  @override
  KenListBoxState createState() => KenListBoxState();
}

class KenListBoxState extends State<KenListBox> {
  List<Widget>? cells;
  dynamic _data;
  ScrollController? _scrollController;
  int? _selectedRow = -1;
  final bool _executeBouncing = false;

  @override
  void initState() {
    _data = widget.data;
    _selectedRow = widget.selectedRow;
    _scrollController = ScrollController();

    String? storageSelectedRow = widget.storageSelectedRow;

    if (storageSelectedRow != null && storageSelectedRow.isNotEmpty) {
      _selectedRow = int.tryParse(storageSelectedRow) ?? widget.selectedRow;
    }
    //_executeBouncing = true;// così in originale

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (context.mounted) {
    //     KenMessageBus.instance.fireEvent(
    //       KenBoxOnListLoaded(
    //           messageBusId:
    //               KenUtilities.getMessageBusId(widget.id!, widget.formKey)),
    //     );
    //   }
    // });

    super.initState();
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
    cells = _getCells();
    if (cells == null) {
      return const KenNotAvailable();
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
        return const KenNotAvailable();
    }

    //_runAutomaticScroll();

    return SingleChildScrollView(
      child: children,
    );
  }

  Widget _getSimpleList(List<Widget> cells) {
    var list = ListView.builder(
      key: Key('${(widget.key as ValueKey).value}_list'),
      controller: _scrollController,
      scrollDirection: widget.orientation!,
      physics: getPhysics(),
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
      key: Key('${(widget.key as ValueKey).value}_list'),
      controller: _scrollController,
      scrollDirection: widget.orientation!,
      shrinkWrap: true,
      physics: getPhysics(),
      itemCount: cells.length,
      itemBuilder: (context, index) {
        return cells[index];
      },
    );

    final container = list;

    return container;
  }

  ScrollPhysics? getPhysics() {
    if (KenConfigurationManager.defaultAutoAdaptHeight!) {
      return const NeverScrollableScrollPhysics();
    } else {
      return _executeBouncing
          ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
          : null;
    }
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
        child: ListWheelScrollView.useDelegate(
          physics: getPhysics(),
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

    final container = list;

    return container;
  }

  List<Widget> _getCells() {
    final cells = List<Widget>.empty(growable: true);

    List? rows = _data['rows'];

    if (widget.defaultSort!.isNotEmpty) {
      //Manage defaultSort setup parameter
      rows!.sort(
          (a, b) => (a[widget.defaultSort]).compareTo(b[widget.defaultSort]));
      _data['rows'] = rows;
    }

    _data['rows'].asMap().forEach((i, dataElement) {
      final infoElement =
          _data['cellsinfo'] != null ? _data['cellsinfo'][i] : null;
      // var _backColor = widget.backColor;
      var backColor =
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
      TextStyle textStyle = getTextStile(backColor);
      TextStyle captionStyle = _getCaptionStile(backColor);

      final cell = KenBox(
        widget.formKey,
        i,
        widget,
        key: Key('${(widget.key as ValueKey).value}_$i'),
        selectedRow: _selectedRow,
        onRefresh: widget.onRefresh,
        showLoader: widget.showLoader,
        id: widget.id,
        layout: widget.layout,
        columns: _data['columns'],
        cellsInfo: infoElement,
        data: dataElement,
        height: widget.height,
        width: widget.width,
        fontColor: widget.fontColor,
        backColor: backColor,
        showSelection: widget.showSelection,
        dismissEnabled: widget.dismissEnabled,
        cardTheme: cardTheme,
        textStyle: textStyle,
        captionStyle: captionStyle,
        isFirestore: widget.isFirestore,
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

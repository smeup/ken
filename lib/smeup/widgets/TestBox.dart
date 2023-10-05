import 'dart:async';

import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:flutter/material.dart';

import '../models/KenMessageBusEvent.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/dynamism.dart';
import '../models/ken_widget_builder_response.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_localization_service.dart';
import '../services/ken_log_service.dart';
import '../services/ken_message_bus.dart';

import 'TestListBox.dart';
import 'kenNotAvailable.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class TestBox extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final Function? onItemTap;
  final Function? onRefresh;
  final Color? backColor;
  final Color? fontColor;
  final List<String> _excludedColumns = ['J4BTN', 'J4IMG'];
  final List<dynamic>? columns;
  final dynamic data;
  final bool? showLoader;
  final String? id;
  final String? layout;
  final List<Dynamism>? dynamisms;
  final double? width;
  final double? height;
  final bool? dismissEnabled;
  final bool? showSelection;
  final int index;
  final int? selectedRow;
  final bool isDynamic;
  final CardTheme? cardTheme;
  final TextStyle? textStyle;
  final TextStyle? captionStyle;
  final Function? onSizeChanged;
  final bool? isFirestore;
  final TestListBox testListBox;
  final String globallyUniqueId;

  TestBox(
    this.scaffoldKey,
    this.formKey,
    this.index,
    this.testListBox, {
    this.id,
    this.isDynamic = false,
    this.selectedRow,
    this.columns,
    this.data,
    this.onRefresh,
    this.dynamisms,
    this.showLoader,
    this.layout,
    this.onItemTap,
    this.backColor,
    this.fontColor,
    this.width,
    this.height,
    this.dismissEnabled,
    this.showSelection,
    this.cardTheme,
    this.textStyle,
    this.captionStyle,
    this.onSizeChanged,
    this.isFirestore,
    required this.globallyUniqueId,
  });

  @override
  _TestBoxState createState() => _TestBoxState();
}

class _TestBoxState extends State<TestBox> with KenWidgetStateMixin {
  List<dynamic>? _columns;
  double elevation = 0;

  bool component = true;

  int manageIndex = -1;

  @override
  void initState() {
    //print('iniziallizato - $initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = FutureBuilder<KenWidgetBuilderResponse>(
      future: _getBoxComponent(),
      builder: (BuildContext context,
          AsyncSnapshot<KenWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //??? va gestito in shiro
          // return widget.showLoader!
          //     ? SmeupWait(widget.scaffoldKey, widget.formKey)
          //     : Container();
          return Container();
        } else {
          if (snapshot.hasError) {
            KenLogService.writeDebugMessage(
                'Error SmeupBox: ${snapshot.error} ${snapshot.stackTrace}. StackTrace: ${snapshot.stackTrace}',
                logType: KenLogType.error);
            notifyError(context, widget.id, snapshot.error);
            return Container();
          } else {
            return snapshot.data!.children!;
          }
        }
      },
    );

    return box;
  }

  Future<KenWidgetBuilderResponse> _getBoxComponent() async {
    Widget box;

    if (widget.showSelection! && widget.index == widget.selectedRow) {
      elevation = 4;
    } else {
      elevation = 0;
    }

    switch (widget.layout ?? '') {
      // layouts Smeup
      case '4':
        box = await _getLayout4(
          widget.data,
        ); // Change the part of the layout based on the number
        break;
      default:
        KenLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: KenLogType.warning);

        box = await _getLayoutDefault(
            widget.data); // if not specified this is the default
        break;
    }
    // bool dismissEnabled = //già presente in originale
    Dynamism? deleteDynamism;

    int no = widget.dynamisms == null
        ? 0
        : widget.dynamisms!
            .where((element) => element.event == 'delete')
            .length;

    if (no > 0) {
      deleteDynamism = widget.dynamisms!.firstWhere(
        (element) => element.event == 'delete',
        //orElse: () => null as Dynamism
      );
    }

    Widget res = widget.dismissEnabled!
        ? Dismissible(
            key: Key('${widget.formKey.toString()}_${widget.id}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection direction) async {
              KenMessageBus.instance.publishRequest(
                widget.globallyUniqueId,
                KenTopic.kenBoxConfirmDismiss,
                KenMessageBusEventData(
                    context: context, widget: widget, model: null, data: null),
              );

              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: KenConfigurationService.getTheme()!,
                    child: AlertDialog(
                      title: Text(KenLocalizationService.of(context)!
                          .getLocalString('confirm')),
                      content: Text(KenLocalizationService.of(context)!
                          .getLocalString(('areYouSureDelete'))),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(KenLocalizationService.of(context)!
                              .getLocalString('delete')),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(KenLocalizationService.of(context)!
                              .getLocalString('cancel')),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            onDismissed: (direction) async {
              await KenMessageBus.instance.publishRequestAndAwait(
                widget.globallyUniqueId,
                KenTopic.kenboxOnDismissed,
                KenMessageBusEventData(
                  context: context,
                  widget: widget,
                  model: null,
                  data: deleteDynamism,
                ),
              );
              // widget.onRefresh!();
            },
            background: Container(
              color: Colors.red,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            child: box,
          )
        : box;

    Widget container;
    if (widget.index == 0) {
      container = MeasureSize(
          onChange: (Size size) {
            if (widget.onSizeChanged != null) widget.onSizeChanged!(size);
          },
          child: _getContainer(res));
    } else {
      container = _getContainer(res);
    }

    return KenWidgetBuilderResponse(null, container);
  }

  Container _getContainer(res) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.transparent,
        width: widget.width,
        child: res);
  }

  Future<Widget> _getLayout4(dynamic data) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
          color: widget.backColor,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: FutureBuilder<Widget>(
              future: _getLayout4Async(data, cols),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  if (snapshot.hasError) {
                    return KenNotAvailable();
                  } else {
                    return snapshot.data!;
                  }
                }
              },
            ),
          ),
        ),
      );
    }

    KenLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: KenLogType.error);

    return KenNotAvailable();
  }

  Future<Widget> _getLayoutDefault(dynamic data) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.backColor,
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: FutureBuilder<Widget>(
                    future: _getLayoutAsync(data, cols),
                    builder:
                        (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        if (snapshot.hasError) {
                          return KenNotAvailable();
                        } else {
                          return snapshot.data!;
                        }
                      }
                    }))),
      );
    }

    KenLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: KenLogType.error);

    return KenNotAvailable();
  }

  /// Layout 2
  ///

  Future<Widget> _getLayoutAsync(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);
    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        final colWidget = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (col['text'].isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(col['text'], style: widget.captionStyle),
                    ],
                  ),
                ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(rowData, style: widget.textStyle), // Right side
                ),
              ),
            ]);

        listOfRows.add(colWidget);
      }
    }

    return Row(
      children: [Expanded(child: Column(children: listOfRows))],
    );
  }

  Future<Widget> _getLayout4Async(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);

    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        if (col['code'] == 'image') {
          // Handle the image column
          final imageWidget = Image.asset(
            rowData, // Assuming rowData contains the path to the image
            width: 100, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          );

          listOfRows.add(imageWidget);
        } else if (col['text'].isNotEmpty) {
          // Handle other columns (role and description)
          final colWidget = Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (col['text'].isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(rowData, style: widget.textStyle),
                      ),
                    ),
                  ),
              ]);

          listOfRows.add(colWidget);
        }
      }
    }

    return Column(
      children: listOfRows,
    );
  }

  Future<List<Widget>> _getBoxTexts(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);

    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);
        final colWidget = Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(rowData, style: widget.textStyle),
          ),
        );

        listOfRows.add(colWidget);
      }
    }
    return listOfRows;
  }

  void _manageTap(index, data) {
    if (widget.onItemTap != null) {
      widget.onItemTap!(index, data, widget.testListBox);
    }
  }

  Future<List?> _getColumns(dynamic data) async {
    if (_columns == null) {
      if (widget.columns != null) {
        _columns = widget.columns;
      } else {
        final response = await KenMessageBus.instance.publishRequestAndAwait(
          widget.globallyUniqueId,
          KenTopic.kenBoxGetButtons,
          KenMessageBusEventData(
              context: context,
              widget: widget,
              model: null,
              data: data,
              parameters: [_columns]),
        );
        _columns = response.data.data;
      }
    }

    return _columns;
  }

  Future<String> _getBoxText(Map data, Map col) async {
    String dataText = "";

    if (widget.isDynamic) {
      final response = await KenMessageBus.instance.publishRequestAndAwait(
        widget.globallyUniqueId +
            widget.index.toString() +
            col["code"].toString(),
        KenTopic.kenboxGetText,
        KenMessageBusEventData(
            context: context,
            widget: widget,
            model: null,
            data: data,
            parameters: [col]),
      );
      dataText = response.data.data;
    } else {
      dataText = data[col['code']].toString();
    }

    return dataText;
  }
}

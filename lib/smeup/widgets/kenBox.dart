import 'dart:async';

import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:flutter/material.dart';

import '../models/KenMessageBusEventData.dart';
import '../models/dynamism.dart';
import '../models/ken_widget_builder_response.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_localization_service.dart';
import '../services/ken_log_service.dart';
import '../services/ken_message_bus.dart';

import 'kenListBox.dart';
import 'kenNotAvailable.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenBox extends StatefulWidget {
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
  final KenListBox kenListBox;
  final String globallyUniqueId;

  KenBox(
    this.scaffoldKey,
    this.formKey,
    this.index,
    this.kenListBox, {
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
  _KenBoxState createState() => _KenBoxState();
}

class _KenBoxState extends State<KenBox> with KenWidgetStateMixin {
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
        box = await _getLayout4(widget.data);
        break;
      default:
        KenLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: KenLogType.warning);

        box = await _getLayoutDefault(widget.data);
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
              Completer<dynamic> completer = Completer();
              KenMessageBus.instance
                  .response(
                      id: widget.globallyUniqueId,
                      topic: KenTopic.kenboxOnDismissed)
                  .take(1)
                  .listen((event) {
                completer.complete(); // resolve promise
              });
              KenMessageBus.instance.publishRequest(
                widget.globallyUniqueId,
                KenTopic.kenboxOnDismissed,
                KenMessageBusEventData(
                    context: context,
                    widget: widget,
                    model: null,
                    data: deleteDynamism),
              );
              await completer.future;
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

  // LAYOUT DEFAULT

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
                    future: _getLayoutDefaultData(data, cols),
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

  Future<Widget> _getLayoutDefaultData(dynamic data, cols) async {
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

  // LAYOUT 4

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

  // OTHER

  Future<Widget> _getLayoutImageList(dynamic data, BuildContext context) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: (widget.cardTheme!.shape as RoundedRectangleBorder)
                .copyWith(side: BorderSide(color: widget.cardTheme!.color!)),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getImageAndDataInColumn(data, cols),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //??? va gestito in shiro
                          // return widget.showLoader!
                          //     ? SmeupWait(widget.scaffoldKey, widget.formKey)
                          //     : Container();
                          return Container();
                        } else {
                          if (snapshot.hasError) {
                            return KenNotAvailable();
                          } else {
                            return snapshot.data!;
                          }
                        }
                      }),
                ))),
      );
    }

    KenLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: KenLogType.error);

    return KenNotAvailable();
  }

  Future<Widget> _getImage(dynamic data) async {
    dynamic widgetImage;

    if (widget.isDynamic) {
      Completer<dynamic> completer = Completer();
      KenMessageBus.instance
          .response(
              id: widget.globallyUniqueId + widget.index.toString(),
              topic: KenTopic.kenBoxGetImage)
          .take(1)
          .listen((event) {
        widgetImage = event.data.data;
        completer.complete(); // resolve promise
      });
      KenMessageBus.instance.publishRequest(
        widget.globallyUniqueId + widget.index.toString(),
        KenTopic.kenBoxGetImage,
        KenMessageBusEventData(
            context: context, widget: widget, model: null, data: data),
      );
      await completer.future;

      if (widgetImage != null) {
        return widgetImage;
      } else {
        return Container();
      }
    } else {
      // TODO static case
      return widgetImage;
    }
  }

  Future<Widget> _getImageAndDataInRow(dynamic data, cols) async {
    //Widget? widgetImg = KenNotAvailable();
    Widget? widgetImg = await _getImage(data);

    var listOfRows = await _getBoxTexts(data, cols);

    return Row(
      children: [widgetImg, Expanded(child: Column(children: listOfRows))],
    );
  }

  Future<Widget> _getImageAndDataInColumn(dynamic data, cols) async {
    Widget widgetImg = await _getImage(data);

    var listOfRows = await _getBoxTexts(data, cols);

    return Column(
      children: [widgetImg, Expanded(child: Column(children: listOfRows))],
    );
  }

  /// Layout 2
  ///

// comportament strano del widget, tuttavia non rispecchia il layout standard necessario

  // Future<Widget> _getLayout4Async(dynamic data, cols) async {
  //   var widgets = List<Widget>.empty(growable: true);
  //   for (var col in cols) {
  //     if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
  //       String rowData = await _getBoxText(data, col);

  //       final textWidget = Container(
  //         padding: const EdgeInsets.all(1),
  //         child: Row(children: [
  //           if (col['text'].isNotEmpty)
  //             Expanded(
  //               flex: 1,
  //               child: Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(col['text'], style: widget.captionStyle),
  //               ),
  //             ),
  //           Expanded(
  //             flex: 2,
  //             child: Align(
  //               alignment: Alignment.centerRight,
  //               child: Text(rowData, style: widget.textStyle),
  //             ),
  //           ),
  //         ]),
  //       );

  //       widgets.add(textWidget);
  //     }
  //   }

  //   var buttonWidgets = await _getButtons(data);

  //   widgets.add(Padding(
  //     padding: const EdgeInsets.only(top: 5),
  //     child: Row(
  //       //crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       //mainAxisSize: MainAxisSize.min,
  //       children: buttonWidgets,
  //     ),
  //   ));

  //   return Row(
  //     children: [Expanded(child: Column(children: widgets))],
  //   );
  // }

  Future<List<Widget>> _getBoxTexts(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);

    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);
        final colWidget = Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(rowData, style: widget.textStyle),
              ),
            ),
          ],
        );

        listOfRows.add(colWidget);
      }
    }
    return listOfRows;
  }

  Future<List<Widget>> _getButtons(dynamic data) async {
    var widgetBtns = List<Widget>.empty(growable: true);

    List<dynamic>? buttonCols;

    var columns = await _getColumns(data);

    Completer<dynamic> completer = Completer();
    KenMessageBus.instance
        .response(
            id: widget.globallyUniqueId,
            topic: KenTopic.kenBoxGetColumnsButtons)
        .take(1)
        .listen((event) {
      buttonCols = event.data.data;
      completer.complete(); // resolve promise
    });
    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenBoxGetColumnsButtons,
      KenMessageBusEventData(
          context: context,
          widget: widget,
          model: null,
          data: columns,
          parameters: [buttonCols]),
    );
    await completer.future;

    completer = Completer();
    KenMessageBus.instance
        .response(id: widget.globallyUniqueId, topic: KenTopic.kenBoxGetButtons)
        .take(1)
        .listen((event) {
      widgetBtns = event.data.data;
      completer.complete(); // resolve promise
    });
    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenBoxGetButtons,
      KenMessageBusEventData(
          context: context,
          widget: widget,
          model: null,
          data: data,
          parameters: [buttonCols]),
    );
    await completer.future;

    return widgetBtns;
  }

  void _manageTap(index, data) {
    if (widget.onItemTap != null) {
      widget.onItemTap!(index, data, widget.kenListBox);
    }
  }

  Future<List?> _getColumns(dynamic data) async {
    if (_columns == null) {
      if (widget.columns != null) {
        _columns = widget.columns;
      } else {
        Completer<dynamic> completer = Completer();
        KenMessageBus.instance
            .response(
                id: widget.globallyUniqueId, topic: KenTopic.kenBoxGetButtons)
            .take(1)
            .listen((event) {
          _columns = event.data.data;
          completer.complete(); // resolve promise
        });
        KenMessageBus.instance.publishRequest(
          widget.globallyUniqueId,
          KenTopic.kenBoxGetButtons,
          KenMessageBusEventData(
              context: context,
              widget: widget,
              model: null,
              data: data,
              parameters: [_columns]),
        );
        await completer.future;
      }
    }

    return _columns;
  }

  Future<String> _getBoxText(Map data, Map col) async {
    String dataText = "";

    if (widget.isDynamic) {
      Completer<dynamic> completer = Completer();
      KenMessageBus.instance
          .response(
              id: widget.globallyUniqueId +
                  widget.index.toString() +
                  col["code"].toString(),
              topic: KenTopic.kenboxGetText)
          .take(1)
          .listen((event) {
        dataText = event.data.data;
        completer.complete(); // resolve promise
      });
      KenMessageBus.instance.publishRequest(
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
      await completer.future;
    } else {
      dataText = data[col['code']].toString();
    }

    return dataText;
  }
}

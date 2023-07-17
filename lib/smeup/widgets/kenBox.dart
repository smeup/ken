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
import 'kenEnumCallback.dart';
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
  final String? globallyUniqueId;

  Future<dynamic> Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenBox(this.scaffoldKey, this.formKey, this.index, this.kenListBox,
      {this.id,
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
      this.globallyUniqueId,
      this.callBack});

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
    print('iniziallizato - $initState');
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
      case '1':
        box = _getLayout1(widget.data, context);
        break;
      case '2':
        box = _getLayout2(widget.data, context);
        break;
      case '3':
        box = _getLayout3(widget.data, context);
        break;
      case '4':
        box = _getLayout4(widget.data, context);
        break;
      case '5':
        box = _getLayout5(widget.data, context);
        break;
      case 'imageList':
        box = _getLayoutImageList(widget.data, context);
        break;
      default:
        KenLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: KenLogType.warning);

        box = _getLayoutDefault(widget.data, context);
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
              // SmeupDynamismService.storeDynamicVariables(
              //     widget.data, widget.formKey);
              if (widget.callBack != null) {
                await widget.callBack!(
                    widget, KenCallbackType.confirmDismiss, null, null);
              }

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
              // var smeupFun = Fun(deleteDynamism!.exec, widget.formKey,
              //     widget.scaffoldKey, context);

              // if (widget.callBack != null) {
              //   await widget.callBack!(
              //       widget, KenCallbackType.onDismissed, deleteDynamism, null);
              // }

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
                widget.globallyUniqueId!,
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
        height: widget.height,
        width: widget.width,
        child: res);
  }

  Widget _getLayout1(dynamic data, BuildContext context) {
    final cols = _getColumns(data);
    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
          manageIndex = widget.index;

          print(
              '1. stato iniziale = $component and context : $context and widgetindex = $_manageTap');
          setState(() {
            component = !component;
            print('stato dopo il click = $component e // ${widget.index}');
          });
        },
        child: Card(
            elevation: elevation,
            color: widget.cardTheme!.color,
            shape: component
                ? widget.cardTheme!.shape
                : RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 3, color: Color.fromARGB(198, 246, 167, 101)),
                    borderRadius: BorderRadius.circular(20)),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                    height: widget.height,
                    child: FutureBuilder<Widget>(
                        future: _getImageAndDataInRow(data, cols),
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
                        })))),
      );
    }

    KenLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: KenLogType.error);

    return KenNotAvailable();
  }

  Widget _getLayout2(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getLayout2Async(data, cols),
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

  Widget _getLayout3(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getLayout3Async(data, cols),
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

  Widget _getLayout4(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: widget.cardTheme!.shape,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getLayout4Async(data, cols),
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

  Widget _getLayout5(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: widget.cardTheme!.shape,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getLayout5Async(data, cols),
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

  Widget _getLayoutImageList(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

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

  Widget _getLayoutDefault(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: FutureBuilder<Widget>(
                      future: _getImageAndDataInRow(data, cols),
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
    if (widget.callBack != null) {
      var imageWidget =
          await widget.callBack!(widget, KenCallbackType.getImage, data, null);

      if (imageWidget != null) {
        return imageWidget;
      } else {
        return Container();
      }
    }
    return Container();
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

  Future<Widget> _getLayout2Async(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);
    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        final colWidget = Container(
            padding: const EdgeInsets.all(1),
            child: Row(children: [
              if (col['text'].isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(col['text'], style: widget.captionStyle),
                  ),
                ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(rowData, style: widget.textStyle),
                ),
              ),
            ]));

        listOfRows.add(colWidget);
      }
    }

    return Row(
      children: [Expanded(child: Column(children: listOfRows))],
    );
  }

  Future<Widget> _getLayout3Async(dynamic data, cols) async {
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

    return Row(
      children: [Expanded(child: Column(children: listOfRows))],
    );
  }

  Future<Widget> _getLayout4Async(dynamic data, cols) async {
    var widgets = List<Widget>.empty(growable: true);
    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        final textWidget = Container(
          padding: const EdgeInsets.all(1),
          child: Row(children: [
            if (col['text'].isNotEmpty)
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(col['text'], style: widget.captionStyle),
                ),
              ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(rowData, style: widget.textStyle),
              ),
            ),
          ]),
        );

        widgets.add(textWidget);
      }
    }

    var buttonWidgets = _getButtons(data);

    widgets.add(Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        //mainAxisSize: MainAxisSize.min,
        children: buttonWidgets,
      ),
    ));

    return Row(
      children: [Expanded(child: Column(children: widgets))],
    );
  }

  Future<Widget> _getLayout5Async(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);
    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        final colWidget = Container(
            padding: const EdgeInsets.all(1),
            child: Row(children: [
              if (col['text'].isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(col['text'], style: widget.captionStyle),
                  ),
                ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(rowData, style: widget.textStyle),
                ),
              ),
            ]));

        listOfRows.add(colWidget);
      }
    }

    return Row(
      children: [Expanded(child: Column(children: listOfRows))],
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

  List<Widget> _getButtons(dynamic data) {
    var widgetBtns = List<Widget>.empty(growable: true);

    var buttonCols = _getColumns(data)!
        .where((col) => col['ogg'] == 'J4BTN' && col['IO'] != 'H');

    if (widget.callBack != null) {
      widgetBtns =
          widget.callBack!(widget, KenCallbackType.getButtons, data, buttonCols)
              as List<Widget>;
    }

    return widgetBtns;
  }

  void _manageTap(index, data) {
    if (widget.onItemTap != null) {
      widget.onItemTap!(index, data, widget.kenListBox);
    }
  }

  List<dynamic>? _getColumns(dynamic data) {
    if (_columns == null) {
      if (widget.columns != null) {
        _columns = widget.columns;
      } else {
        _columns = List<dynamic>.empty(growable: true);
        (data as Map).keys.forEach((element) {
          _columns!.add({
            "code": element,
            "fieldNameForDecode": null,
            "text": element,
            "tip": null,
            "dpy": null,
            "aut": null,
            "lun": null,
            "lunNum": null,
            "fill": null,
            "ogg": null,
            "obb": null,
            "eTxt": null,
            "grp": null,
            "extension": null,
            "formula": null,
            "tfk": null,
            "pfk": null,
            "sfk": null,
            "sortMode": null,
            "filterValue": null,
            "IO": "O"
          });
        });
      }
    }

    return _columns;
  }

  Future<String> _getBoxText(Map data, Map col) async {
    String dataText = "";
    // if (widget.callBack != null) {
    //   dataText =
    //       await widget.callBack!(widget, KenCallbackType.getBoxText, data, col)
    //           as String;
    // }

    Completer<dynamic> completer = Completer();
    KenMessageBus.instance
        .response(
            id: widget.globallyUniqueId! +
                widget.index.toString() +
                col["code"].toString(),
            topic: KenTopic.kenboxGetText)
        .take(1)
        .listen((event) {
      //print('xxxxxxxxxxxxxxx:' + event.data.data.toString());
      dataText = event.data.data;
      completer.complete(); // resolve promise
    });
    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId! +
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

    return dataText;
  }
}

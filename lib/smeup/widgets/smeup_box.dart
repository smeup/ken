import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

class SmeupBox extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function onItemTap;
  final Function onRefresh;
  final Color cardColor;
  final Color fontColor;
  final List<String> _excludedColumns = ['J4BTN', 'J4IMG'];
  final List<dynamic> columns;
  final dynamic data;
  final bool showLoader;
  final String id;
  final String layout;
  final dynamic dynamisms;
  final double width;
  final double height;
  final bool dismissEnabled;

  SmeupBox(this.scaffoldKey, this.formKey,
      {this.id,
      this.columns,
      this.data,
      this.onRefresh,
      this.dynamisms,
      this.showLoader,
      this.layout,
      this.onItemTap,
      this.cardColor,
      this.fontColor,
      this.width,
      this.height,
      this.dismissEnabled});

  @override
  _SmeupBoxState createState() => _SmeupBoxState();
}

class _SmeupBoxState extends State<SmeupBox> with SmeupWidgetStateMixin {
  List<dynamic> _columns;

  @override
  Widget build(BuildContext context) {
    final box = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getBoxComponent(),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupBox: ${snapshot.error} ${snapshot.stackTrace}',
                logType: LogType.error);
            notifyError(context, widget.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return box;
  }

  Future<SmeupWidgetBuilderResponse> _getBoxComponent() async {
    Widget box;

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
      default:
        SmeupLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: LogType.warning);

        box = _getLayoutDefault(widget.data, context);
        break;
    }

    // bool dismissEnabled = false;
    dynamic deleteDynamism;
    if (widget.dynamisms != null)
      deleteDynamism = (widget.dynamisms as List<dynamic>).firstWhere(
          (element) => element['event'] == 'delete',
          orElse: () => null);

    // if (deleteDynamism != null) {
    //   dismissEnabled = true;
    // }

    Widget res = widget.dismissEnabled
        ? Dismissible(
            key: Key('${widget.formKey.toString()}_${widget.id}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection direction) async {
              SmeupDynamismService.storeDynamicVariables(widget.data);
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(SmeupLocalizationService.of(context)
                        .getLocalString('confirm')),
                    content: Text(SmeupLocalizationService.of(context)
                        .getLocalString(('areYouSureDelete'))),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(SmeupLocalizationService.of(context)
                            .getLocalString('delete')),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(SmeupLocalizationService.of(context)
                            .getLocalString('cancel')),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) async {
              var smeupFun = SmeupFun(deleteDynamism['exec']);
              var smeupServiceResponse =
                  await SmeupDataService.invoke(smeupFun);
              SmeupDynamismService.manageResponseMessage(
                  context, smeupServiceResponse.result, widget.scaffoldKey);
              widget.onRefresh();
            },
            background: Container(
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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

    final container = Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.transparent,
        height: widget.height == 0 ? double.infinity : widget.height,
        width: widget.width == 0 ? double.infinity : widget.width,
        child: res);

    return SmeupWidgetBuilderResponse(null, container);
  }

  Widget _getLayout1(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: SmeupOptions.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: widget.fontColor ??
                                          SmeupOptions.theme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );

                          listOfRows.add(colWidget);
                        }
                      });

                      Widget widgetImg = _getImage(data);

                      return [
                        if (widgetImg != null) widgetImg,
                        Expanded(child: Column(children: listOfRows))
                      ];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getLayout2(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            // shape: RoundedRectangleBorder(
            //   side:
            //       BorderSide(color: SmeupOptions.theme.primaryColor, width: 2),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final colWidget = Container(
                              padding: EdgeInsets.all(1),
                              child: Row(children: [
                                if (col['text'].isNotEmpty)
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(col['text'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                    ),
                                  ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(rowData,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]));

                          listOfRows.add(colWidget);
                        }
                      });

                      return [Expanded(child: Column(children: listOfRows))];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getLayout3(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: widget.fontColor ??
                                          SmeupOptions.theme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );

                          listOfRows.add(colWidget);
                        }
                      });

                      return [Expanded(child: Column(children: listOfRows))];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getLayout4(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: SmeupOptions.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var widgets = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final textWidget = Container(
                            padding: EdgeInsets.all(1),
                            child: Row(children: [
                              if (col['text'].isNotEmpty)
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(col['text'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(rowData,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ]),
                          );

                          widgets.add(textWidget);
                        }
                      });

                      var buttonWidgets = _getButtons(data);

                      if (buttonWidgets != null) {
                        widgets.add(Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            //mainAxisSize: MainAxisSize.min,
                            children: buttonWidgets,
                          ),
                        ));
                      }

                      return [Expanded(child: Column(children: widgets))];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getLayout5(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: SmeupOptions.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final colWidget = Container(
                              padding: EdgeInsets.all(1),
                              child: Row(children: [
                                if (col['text'].isNotEmpty)
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(col['text'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                    ),
                                  ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(rowData,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]));

                          listOfRows.add(colWidget);
                        }
                      });

                      return [Expanded(child: Column(children: listOfRows))];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getLayoutDefault(dynamic data, BuildContext context) {
    final cols = _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        onTap: () {
          _manageTap(data);
        },
        child: Card(
            color: widget.cardColor ?? null,
            shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: SmeupOptions.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          if (col['ogg'] == 'D8*YYMD') {
                            rowData = DateFormat("dd/MM/yyyy")
                                .format(DateTime.tryParse(rowData));
                          }

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: widget.fontColor ??
                                          SmeupOptions.theme.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          );

                          listOfRows.add(colWidget);
                        }
                      });

                      return [Expanded(child: Column(children: listOfRows))];
                    }(),
                  ),
                ))),
      );
    }

    SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
        logType: LogType.error);

    return SmeupNotAvailable();
  }

  Widget _getImage(dynamic data) {
    Widget widgetImg;
    var colImg = _getColumns(data).firstWhere(
        (col) => col['ogg'] == 'J4IMG' && col['IO'] != 'H',
        orElse: () => null);
    if (colImg != null) {
      final String imageColName = colImg['code'];
      final String ogg = data[imageColName];
      final List split = ogg.split(';');
      if (split.length == 3)
        widgetImg = Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.network(
            split[2],
            fit: BoxFit.contain,
          ),
        );
    }
    return widgetImg;
  }

  List<Widget> _getButtons(dynamic data) {
    var widgetBtns = List<Widget>.empty(growable: true);

    var buttonCols = _getColumns(data)
        .where((col) => col['ogg'] == 'J4BTN' && col['IO'] != 'H');

    buttonCols.forEach((col) {
      final String imageColName = col['code'];
      final String ogg = data[imageColName];

      String buttonText = SmeupFun.extractArg(ogg, 'T');
      String buttonFun = SmeupFun.extractArg(ogg, 'E');
      String buttonIcon = SmeupFun.extractArg(ogg, 'I');

      final List split = buttonIcon.split(';');
      if (split.length == 3) {
        buttonIcon = split[2];
      }

      // buttonText = '';
      final double padding = buttonText.isEmpty ? 0 : 10;

      Widget widgetBtn = Expanded(
        flex: buttonText.isEmpty ? 0 : 1,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: () {
              if (buttonCols.length == 1) {
                return EdgeInsets.only(left: padding, right: padding);
              } else {
                if (widgetBtns.length == 0) {
                  return EdgeInsets.only(right: padding);
                } else if (widgetBtns.length + 1 == buttonCols.length) {
                  return EdgeInsets.only(left: padding);
                } else {
                  return EdgeInsets.only(left: padding, right: padding);
                }
              }
            }(),
            child: SmeupButton(
              height: 50,
              width: buttonText.isEmpty ? 50 : 0,
              backColor: buttonText.isEmpty
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).primaryColor,
              borderColor: buttonText.isEmpty
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).primaryColor,
              fontColor: buttonText.isEmpty
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
              iconData: int.tryParse(buttonIcon) ?? 0,
              data: buttonText,
              clientOnPressed: () {
                //SmeupDynamismService.storeDynamicVariables(_child['content']);

                List<dynamic> dynamisms = [
                  {
                    "event": "click",
                    "exec": buttonFun,
                  }
                ];
                SmeupDynamismService.run(
                    dynamisms, context, "click", widget.scaffoldKey);
              },
            ),
          ),
        ),
      );
      widgetBtns.add(widgetBtn);
    });

    return widgetBtns;
  }

  void _manageTap(data) {
    if (widget.onItemTap != null) {
      widget.onItemTap(data);
    }
  }

  List<dynamic> _getColumns(dynamic data) {
    if (_columns == null) {
      if (widget.columns != null)
        _columns = widget.columns;
      else {
        _columns = List<dynamic>.empty(growable: true);
        (data as Map).keys.forEach((element) {
          _columns.add({
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
}

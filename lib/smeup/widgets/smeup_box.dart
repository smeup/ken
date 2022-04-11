import 'dart:async';

import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/dynamism.dart';
import 'package:ken/smeup/models/widgets/smeup_image_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/SmeupLocalizationService.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_message_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_button.dart';
import 'package:ken/smeup/widgets/smeup_image.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_wait.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

import '../models/fun.dart';

class SmeupBox extends StatefulWidget {
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

  SmeupBox(this.scaffoldKey, this.formKey, this.index,
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
      this.onSizeChanged});

  @override
  _SmeupBoxState createState() => _SmeupBoxState();
}

class _SmeupBoxState extends State<SmeupBox> with SmeupWidgetStateMixin {
  List<dynamic>? _columns;
  double? borderSize;

  @override
  Widget build(BuildContext context) {
    final box = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getBoxComponent(),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.showLoader!
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupBox: ${snapshot.error} ${snapshot.stackTrace}. StackTrace: ${snapshot.stackTrace}',
                logType: LogType.error);
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

  Future<SmeupWidgetBuilderResponse> _getBoxComponent() async {
    Widget box;

    if (widget.showSelection! && widget.index == widget.selectedRow) {
      borderSize = 4;
    } else {
      borderSize = 2;
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
        SmeupLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: LogType.warning);

        box = _getLayoutDefault(widget.data, context);
        break;
    }

    // bool dismissEnabled = false;
    Dynamism? deleteDynamism;

    int no = widget.dynamisms == null
        ? 0
        : widget.dynamisms!
            .where((element) => element.event == 'delete')
            .length;

    if (no > 0)
      deleteDynamism = widget.dynamisms!.firstWhere(
          (element) => element.event == 'delete',
          orElse: () => null as Dynamism);

    Widget res = widget.dismissEnabled!
        ? Dismissible(
            key: Key('${widget.formKey.toString()}_${widget.id}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection direction) async {
              SmeupDynamismService.storeDynamicVariables(
                  widget.data, widget.formKey);
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: SmeupConfigurationService.getTheme()!,
                    child: AlertDialog(
                      title: Text(SmeupLocalizationService.of(context)!
                          .getLocalString('confirm')),
                      content: Text(SmeupLocalizationService.of(context)!
                          .getLocalString(('areYouSureDelete'))),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(SmeupLocalizationService.of(context)!
                              .getLocalString('delete')),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(SmeupLocalizationService.of(context)!
                              .getLocalString('cancel')),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            onDismissed: (direction) async {
              var smeupFun = Fun(deleteDynamism!.exec, widget.formKey,
                  widget.scaffoldKey, context);
              var smeupServiceResponse =
                  await SmeupDataService.invoke(smeupFun);
              SmeupMessageDataService.manageResponseMessage(
                  context, smeupServiceResponse.result);
              widget.onRefresh!();
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

    return SmeupWidgetBuilderResponse(null, container);
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
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: widget.cardTheme!.shape,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData, style: widget.textStyle),
                            ),
                          );

                          listOfRows.add(colWidget);
                        }
                      });

                      Widget widgetImg = FutureBuilder<Widget>(
                          future: _getImage(data),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SmeupWait(
                                  widget.scaffoldKey, widget.formKey);
                            } else {
                              if (snapshot.hasError) {
                                return SmeupNotAvailable();
                              } else {
                                return snapshot.data!;
                              }
                            }
                          });

                      return [
                        widgetImg,
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
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final colWidget = Container(
                              padding: EdgeInsets.all(1),
                              child: Row(children: [
                                if (col['text'].isNotEmpty)
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(col['text'],
                                          style: widget.captionStyle),
                                    ),
                                  ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        Text(rowData, style: widget.textStyle),
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
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData, style: widget.textStyle),
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
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: widget.cardTheme!.shape,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var widgets = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final textWidget = Container(
                            padding: EdgeInsets.all(1),
                            child: Row(children: [
                              if (col['text'].isNotEmpty)
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(col['text'],
                                        style: widget.captionStyle),
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
                      });

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
          _manageTap(widget.index, data);
        },
        child: Card(
            color: widget.cardTheme!.color,
            shape: widget.cardTheme!.shape,
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: widget.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final colWidget = Container(
                              padding: EdgeInsets.all(1),
                              child: Row(children: [
                                if (col['text'].isNotEmpty)
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(col['text'],
                                          style: widget.captionStyle),
                                    ),
                                  ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        Text(rowData, style: widget.textStyle),
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
                  child: Column(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H') {
                          String rowData = data[col['code']].toString();
                          if (rowData.isNotEmpty) {
                            final colWidget = Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(rowData, style: widget.textStyle),
                              ),
                            );

                            listOfRows.add(colWidget);
                          }
                        }
                      });

                      Widget widgetImg = FutureBuilder<Widget>(
                          future: _getImage(data),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SmeupWait(
                                  widget.scaffoldKey, widget.formKey);
                            } else {
                              if (snapshot.hasError) {
                                return SmeupNotAvailable();
                              } else {
                                return snapshot.data!;
                              }
                            }
                          });

                      return [
                        widgetImg,
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
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols!.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']].toString();

                          final colWidget = Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(rowData,
                                  textAlign: TextAlign.center,
                                  style: widget.textStyle),
                            ),
                          );

                          listOfRows.add(colWidget);
                        }
                      });

                      //return [Expanded(child: Column(children: listOfRows))];
                      Widget widgetImg = FutureBuilder<Widget>(
                          future: _getImage(data),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SmeupWait(
                                  widget.scaffoldKey, widget.formKey);
                            } else {
                              if (snapshot.hasError) {
                                return SmeupNotAvailable();
                              } else {
                                return snapshot.data!;
                              }
                            }
                          });

                      //await _getImage(data);

                      return [
                        widgetImg,
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

  Future<Widget> _getImage(dynamic data) async {
    Widget? widgetImg;
    if (widget.isDynamic) {
      var colImg;
      try {
        colImg = _getColumns(data)!.firstWhere(
            (col) => col['ogg'] == 'J4IMG' && col['IO'] != 'H',
            orElse: () => null);
      } catch (e) {}

      String? code = '';
      String? type = '';
      String? parameter = '';
      if (colImg != null) {
        final String? imageColName = colImg['code'];
        final String ogg = data[imageColName];
        final List split = ogg.split(';');
        if (split.length == 3) {
          type = split[0];
          parameter = split[1];
          code = split[2];
        }
      } else {
        type = data['tipo'] ?? data['type'];
        parameter = data['parametro'] ?? data['parameter'];
        code = data['codice'] ?? data['code'];
      }

      if (type != null &&
          parameter != null &&
          code != null &&
          type.isNotEmpty &&
          parameter.isNotEmpty &&
          code.isNotEmpty) {
        bool validURL = Uri.parse(code).isAbsolute;

        if (validURL) {
          widgetImg = Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              code,
              fit: BoxFit.contain,
            ),
          );
        } else {
          final fun = {
            "fun": {
              "component": "TRE",
              "service": "JASER_12",
              "function": "IMG.LIS",
              "obj1": {"t": "$type", "p": "$parameter", "k": "$code"},
              "obj2": {"t": "", "p": "", "k": ""},
              "obj3": {"t": "", "p": "", "k": ""},
              "obj4": {"t": "", "p": "", "k": ""},
              "obj5": {"t": "", "p": "", "k": ""},
              "obj6": {"t": "", "p": "", "k": ""},
              "P": "",
              "SG": {'cache': 60, 'forceCache': false},
              "INPUT": ""
            }
          };

          final smeupFun =
              Fun(fun, widget.formKey, widget.scaffoldKey, context);

          final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);
          if (!smeupServiceResponse.succeded) {
            SmeupLogService.writeDebugMessage(
                "_getImage error in SmeupBox: ${smeupServiceResponse.result} - Try to retry",
                logType: LogType.error);
            //return Container();
          } else {
            final imgList = smeupServiceResponse.result.data['rows'];

            widgetImg = await _fetchAvailableLinks(imgList);
          }
        }
      } else {
        widgetImg = _getSmeupImage(data);
      }
    } else {
      widgetImg = _getSmeupImage(data);
    }
    return widgetImg ?? Container();
  }

  Widget? _getSmeupImage(data) {
    Widget? widgetImg;
    if (data['isRemote'] != null) {
      bool? isRemote = SmeupImageModel.defaultIsRemote;
      double? imageHeight = SmeupImageModel.defaultHeight;
      double? imageWidth = SmeupImageModel.defaultWidth;
      EdgeInsetsGeometry? imagePadding = SmeupImageModel.defaultPadding;
      if (data['isRemote'] != null) {
        isRemote = data['isRemote'];
      }
      if (data['height'] != null) {
        imageHeight = SmeupUtilities.getDouble(data['height']);
      }
      if (data['width'] != null) {
        imageWidth = SmeupUtilities.getDouble(data['width']);
      }
      if (data['padding'] != null) {
        imagePadding = SmeupUtilities.getPadding(data['padding']);
      }

      widgetImg = SmeupImage(
        widget.scaffoldKey,
        widget.formKey,
        data['code'],
        isRemote: isRemote,
        height: imageHeight,
        width: imageWidth,
        padding: imagePadding,
      );
    }
    return widgetImg;
  }

  Future<Widget> _fetchAvailableLinks(imgList) async {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.network(
        imgList[0]['codice'],
        fit: BoxFit.contain,
      ),
    );
  }

  List<Widget> _getButtons(dynamic data) {
    var widgetBtns = List<Widget>.empty(growable: true);

    var buttonCols = _getColumns(data)!
        .where((col) => col['ogg'] == 'J4BTN' && col['IO'] != 'H');

    buttonCols.forEach((col) {
      final String? imageColName = col['code'];
      final String ogg = data[imageColName];

      String buttonText = Fun.extractArg(ogg, 'T');
      String buttonFun = Fun.extractArg(ogg, 'E');
      String buttonIcon = Fun.extractArg(ogg, 'I');

      final List split = buttonIcon.split(';');
      if (split.length == 3) {
        buttonIcon = split[2];
      }

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
              iconData: int.tryParse(buttonIcon) ?? 0,
              data: buttonText,
              clientOnPressed: () {
                List<Dynamism> dynamisms = [
                  Dynamism(
                      "click",
                      buttonFun,
                      false,
                      List<dynamic>.empty(growable: true),
                      List<dynamic>.empty(growable: true))
                ];
                SmeupDynamismService.run(dynamisms, context, "click",
                    widget.scaffoldKey, widget.formKey);
              },
            ),
          ),
        ),
      );
      widgetBtns.add(widgetBtn);
    });

    return widgetBtns;
  }

  void _manageTap(index, data) {
    if (widget.onItemTap != null) {
      widget.onItemTap!(index, data);
    }
  }

  List<dynamic>? _getColumns(dynamic data) {
    if (_columns == null) {
      if (widget.columns != null)
        _columns = widget.columns;
      else {
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
}

import 'dart:async';
import 'dart:io';

import 'package:clickable_list_wheel_view/measure_size.dart';
import 'package:flutter/material.dart';

import '../managers/ken_configuration_manager.dart';
import '../managers/ken_localization_manager.dart';

import '../helpers/ken_utilities.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_not_available.dart';
import 'ken_list_box.dart';

class KenBox extends StatefulWidget {
  final GlobalKey<ScaffoldState> formKey;
  final Function? onRefresh;
  final Color? backColor;
  final Color? fontColor;
  final List<String> _excludedColumns = [
    'J4BTN',
    'J4IMG',
    'J1',
    'VO',
    'J4',
    'VOCOD_VER',
  ];
  final List<dynamic>? columns;
  final dynamic data;
  final bool? showLoader;
  final String? id;
  final String? layout;
  final double? width;
  final double? height;
  final bool? dismissEnabled;
  final bool? showSelection;
  final int index;
  final int? selectedRow;
  final CardTheme? cardTheme;
  final TextStyle? textStyle;
  final TextStyle? captionStyle;
  final bool? isFirestore;
  final KenListBox kenListBox;
  final Function? onConfirmDismiss;
  final Function? onGetBoxImage;
  final Function? onGetBoxText;
  final Function? onGetButtons;
  final Function? onGetButtonsColumns;

  KenBox(this.formKey, this.index, this.kenListBox,
      {super.key,
      this.id,
      this.selectedRow,
      this.columns,
      this.data,
      this.onRefresh,
      this.showLoader,
      this.layout,
      this.backColor,
      this.fontColor,
      this.width,
      this.height,
      this.dismissEnabled,
      this.showSelection,
      this.cardTheme,
      this.textStyle,
      this.captionStyle,
      this.isFirestore,
      this.onConfirmDismiss,
      this.onGetBoxImage,
      this.onGetBoxText,
      this.onGetButtons,
      this.onGetButtonsColumns});

  @override
  KenBoxState createState() => KenBoxState();
}

class KenBoxState extends State<KenBox> {
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
    final box = FutureBuilder<Widget>(
      future: _getBoxComponent(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //??? va gestito in shiro
          // return widget.showLoader!
          //     ? SmeupWait(widget.formKey)
          //     : Container();
          return Container();
        } else {
          if (snapshot.hasError) {
            debugPrint(
                'Error SmeupBox: ${snapshot.error} ${snapshot.stackTrace}. StackTrace: ${snapshot.stackTrace}');
            return Container();
          } else {
            return snapshot.data!;
          }
        }
      },
    );

    return box;
  }

  Future<Widget> _getBoxComponent() async {
    Widget box;

    if (widget.showSelection! && widget.index == widget.selectedRow) {
      elevation = 4;
    } else {
      elevation = 0;
    }

    switch (widget.layout ?? '') {
      case '1':
        box = await _getLayout1(widget.data);
        break;
      // layouts Smeup
      case '4':
        box = await _getLayout4(widget.data);
        break;
      case 'button':
        box = await _getLayoutButtons(widget.data);
      case 'imageList':
        box = await _getLayoutImageList(widget.data);
        break;
      default:
        box = await _getLayout1(widget.data);
        break;
      // Coomentato il default
      // default:
      // debugPrint('No layout received. Used default layout');
      // box = await _getLayoutDefault(widget.data);
      // break;
    }

    Widget res = widget.dismissEnabled!
        ? Dismissible(
            key: Key('${widget.formKey.toString()}_${widget.id}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection direction) async {
              if (widget.onConfirmDismiss != null) {
                widget.onConfirmDismiss!();
              }

              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Theme(
                    data: KenConfigurationManager.getTheme()!,
                    child: AlertDialog(
                      title: Text(KenLocalizationManager.of(context)!
                          .getLocalString('confirm')),
                      content: Text(KenLocalizationManager.of(context)!
                          .getLocalString(('areYouSureDelete'))),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(KenLocalizationManager.of(context)!
                              .getLocalString('delete')),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(KenLocalizationManager.of(context)!
                              .getLocalString('cancel')),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            onDismissed: (direction) {
              KenMessageBus.instance.fireEvent(KenBoxOnDismissedEvent(
                messageBusId:
                    KenUtilities.getMessageBusId(widget.id!, widget.formKey),
                direction: direction,
              ));
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
      container =
          MeasureSize(onChange: (Size size) {}, child: _getContainer(res));
    } else {
      container = _getContainer(res);
    }

    return container;
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
        key: Key('${(widget.key as ValueKey).value}_gesture_detector'),
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            key: Key('${(widget.key as ValueKey).value}_card'),
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
                          return const KenNotAvailable();
                        } else {
                          return snapshot.data!;
                        }
                      }
                    }))),
      );
    }

    debugPrint('Error SmeupBox widget not created');

    return const KenNotAvailable();
  }

  Future<Widget> _getLayoutDefaultData(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);
    int visibleCols = 0;
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

        visibleCols++;
        listOfRows.add(colWidget);
      }
    }

    if (widget.index == 0 && visibleCols > 0) {
      double rowHeight =
          Platform.isIOS ? 16 : 14; // ogni riga è testo + padding ( 10
      KenMessageBus.instance.fireEvent(
        KenBoxOnSizeChanged(
          messageBusId:
              KenUtilities.getMessageBusId(widget.id!, widget.formKey),
          height: (visibleCols * rowHeight) + 46,
        ),
      );
    }

    return Row(
      children: [Expanded(child: Column(children: listOfRows))],
    );
  }

  // LAYOUT 1
  // XPPPPPPX
  /// A scopo dimostrativo c'è un controllo su una colonna, ma poi mi aspetto che il nome del layout mi arrivi da un'altra parte
  /////////////////////////////////
  ///   RIMUOVERE CONDIZIONE    ///
  /////////////////////////////////

  Future<Widget> _getLayout1(dynamic data) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        key: Key('${(widget.key as ValueKey).value}_gesture_detector'),
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            key: Key('${(widget.key as ValueKey).value}_card'),
            color: widget.backColor,
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: FutureBuilder<Widget>(
                    future: _getLayoutDefault1(data, cols),
                    builder:
                        (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        if (snapshot.hasError) {
                          return const KenNotAvailable();
                        } else {
                          return snapshot.data!;
                        }
                      }
                    }))),
      );
    }

    debugPrint('Error SmeupBox widget not created');

    return const KenNotAvailable();
  }

  Future<Widget> _getLayoutDefault1(dynamic data, cols) async {
    var listOfRows = List<Widget>.empty(growable: true);
    int visibleCols = 0;
    int visibleBigCols = 0;
    int visibleList = 0;
    int defaultVisibleCols = 0;
    var count = 0;
    for (var col in cols) {
      if (col['IO'] != 'H' && !widget._excludedColumns.contains(col['ogg'])) {
        String rowData = await _getBoxText(data, col);

        if (data["tipo"] == "NR") {
          if (col['canonicalForm'].toString().contains("V2") &&
              !(col['canonicalForm'].toString().contains("JL"))) {
            count++;
            final colWidget = Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (count == 1)
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(rowData,
                              style: const TextStyle(
                                  color: kSecondary100,
                                  fontSize: 37,
                                  fontWeight: FontWeight.w600,
                                  backgroundColor:
                                      Colors.transparent)), // Right side
                        ),
                      ),
                    if (count != 1)
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('${col['text']} $rowData',
                              style: widget.captionStyle), // Right side
                        ),
                      ),
                  ]),
            );

            visibleBigCols = 1;
            visibleCols = count - 1;
            listOfRows.add(colWidget);
          }

          if (col['canonicalForm'].toString().contains("JL")) {
            final colWidget = Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: kSecondary100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                          List<Widget>.from(rowData.split(';').map((letter) {
                        return _getIcon(
                            letter); // Ottieni l'icona per ogni lettera nella stringa
                      })).toList()),
                ]);

            visibleList++;
            listOfRows.add(colWidget);
          }
        } else {
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

          defaultVisibleCols++;
          listOfRows.add(colWidget);
        }
      }
    }

    if (data["tipo"] == "NR") {
      if (widget.index == 0 &&
          (visibleCols + visibleBigCols + visibleList) > 0) {
        double rowHeight = 14;
        int cardHeight = 8;
        double bigTitle = Platform.isIOS ? 44 : 43;
        double visibleListHeight = Platform.isIOS ? 63 : 62;
        final sumHeight = ((visibleCols * rowHeight) +
            (defaultVisibleCols * rowHeight) +
            (visibleBigCols * bigTitle) +
            (visibleList * visibleListHeight) +
            28 +
            10 +
            cardHeight);
        KenMessageBus.instance.fireEvent(
          KenBoxOnSizeChanged(
              messageBusId:
                  KenUtilities.getMessageBusId(widget.id!, widget.formKey),
              height: sumHeight),
        );
      }
    } else {
      if (widget.index == 0 && visibleCols > 0) {
        double rowHeight =
            Platform.isIOS ? 16 : 14; // ogni riga è testo + padding ( 10
        KenMessageBus.instance.fireEvent(
          KenBoxOnSizeChanged(
              messageBusId:
                  KenUtilities.getMessageBusId(widget.id!, widget.formKey),
              height: (visibleCols * rowHeight)),
        );
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
        key: Key('${(widget.key as ValueKey).value}_gesture_detector'),
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
                    return const KenNotAvailable();
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

    debugPrint('Error KenBox widget not created');

    return const KenNotAvailable();
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
        } else if (col['canonicalForm'].toString().contains("JL")) {
          final colWidget2 = Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (col['text'].isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child:
                            Text(rowData, style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ),
              ]);
          listOfRows.add(colWidget2);
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

  // LAYOUT WITH BUTTONS

  Future<Widget> _getLayoutButtons(dynamic data) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        key: Key('${(widget.key as ValueKey).value}_gesture_detector'),
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
                      future: _getLayoutButtonAsync(data, cols),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //??? va gestito in shiro
                          // return widget.showLoader!
                          //     ? SmeupWait(widget.formKey)
                          //     : Container();
                          return Container();
                        } else {
                          if (snapshot.hasError) {
                            return const KenNotAvailable();
                          } else {
                            return snapshot.data!;
                          }
                        }
                      }),
                ))),
      );
    }

    debugPrint('Error SmeupBox widget not created');

    return const KenNotAvailable();
  }

  Future<Widget> _getLayoutButtonAsync(dynamic data, cols) async {
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

    var buttonWidgets = await _getButtons(data);

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

  // OTHER

  Future<Widget> _getLayoutImageList(dynamic data) async {
    final cols = await _getColumns(data);

    if (data.length > 0) {
      return GestureDetector(
        key: Key('${(widget.key as ValueKey).value}_gesture_detector'),
        onTap: () {
          _manageTap(widget.index, data);
        },
        child: Card(
            key: Key('${(widget.key as ValueKey).value}_card'),
            color: widget.cardTheme!.color,
            shape: (widget.cardTheme!.shape as RoundedRectangleBorder)
                .copyWith(side: BorderSide(color: widget.cardTheme!.color!)),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: FutureBuilder<Widget>(
                      future: _getImageAndDataInColumn(data, cols),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //??? va gestito in shiro
                          // return widget.showLoader!
                          //     ? SmeupWait(widget.formKey)
                          //     : Container();
                          return Container();
                        } else {
                          if (snapshot.hasError) {
                            return const KenNotAvailable();
                          } else {
                            return snapshot.data!;
                          }
                        }
                      }),
                ))),
      );
    }

    debugPrint('Error SmeupBox widget not created');

    return const KenNotAvailable();
  }

  Future<Widget> _getImage(dynamic data) async {
    Widget widgetImage = Container();

    if (widget.onGetBoxImage != null) {
      widgetImage = await widget.onGetBoxImage!(data, widget);
    }

    return widgetImage;
  }

  // Future<Widget> _getImageAndDataInRow(dynamic data, cols) async {
  //   //Widget? widgetImg = KenNotAvailable();
  //   Widget? widgetImg = await _getImage(data);

  //   var listOfRows = await _getBoxTexts(data, cols);

  //   return Row(
  //     children: [widgetImg, Expanded(child: Column(children: listOfRows))],
  //   );
  // }

  Future<Widget> _getImageAndDataInColumn(dynamic data, cols) async {
    Widget widgetImg = await _getImage(data);

    var listOfRows = await _getBoxTexts(data, cols);

    return Column(
      children: [widgetImg, Column(children: listOfRows)],
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
        final colWidget = SizedBox(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(rowData, style: widget.textStyle),
              ),
            ],
          ),
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

    if (widget.onGetButtonsColumns != null) {
      buttonCols = widget.onGetButtonsColumns!(columns);
    }

    if (widget.onGetButtons != null) {
      widgetBtns = widget.onGetButtons!(data, buttonCols);
    }

    return widgetBtns;
  }

  void _manageTap(index, data) {
    KenMessageBus.instance.fireEvent(
      KenBoxOnItemTapEvent(
        messageBusId: KenUtilities.getMessageBusId(widget.id!, widget.formKey),
        index: index,
        data: data,
        showSelection: widget.kenListBox.showSelection ?? false,
      ),
    );
  }

  Future<List?> _getColumns(dynamic data) async {
    if (_columns == null) {
      if (widget.columns != null) {
        _columns = widget.columns;
      } else {
        _columns = widget.onGetButtons!(data, _columns);
      }
    }

    return _columns;
  }

  Future<String> _getBoxText(Map data, Map col) async {
    String dataText = "";

    if (widget.onGetBoxText != null) {
      dataText = await widget.onGetBoxText!(data, widget, col);
    } else {
      dataText = data[col['code']].toString();
    }

    return dataText;
  }

  Widget _getIcon(String letter) {
    if (letter == '') letter = 'None';
    Map<String, IconData> iconMap = {
      'C': Icons.desktop_mac, // client
      'P': Icons.phone, // phone
      'T': Icons.tablet, // tablet
      'W': Icons.web_asset, // web
      'None': Icons.error
    };

    if (iconMap.containsKey(letter)) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                60, 224, 224, 224), // Set the gray background color
            borderRadius: BorderRadius.circular(
                4.0), // Set border radius for rectangular shape
            border: Border.all(
              color: Colors.white, // Set the color of the border
              width: 1.0, // Set the width of the border
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                  letter,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  iconMap[letter],
                  size: 14,
                  color: Colors.white, // Icon color
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(); // If the letter is not found, return an empty SizedBox
    }
  }
}

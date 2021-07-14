import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_box_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

class SmeupBox extends StatefulWidget {
  final SmeupBoxModel smeupBoxModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function onServerPressed;
  final Function onClientPressed;
  final Color cardColor;
  final Color fontColor;
  final List<String> _excludedColumns = ['J4BTN', 'J4IMG'];

  SmeupBox(
    this.smeupBoxModel,
    this.scaffoldKey,
    this.formKey, {
    this.onServerPressed,
    this.onClientPressed,
    this.cardColor,
    this.fontColor,
  });

  @override
  _SmeupBoxState createState() => _SmeupBoxState();
}

class _SmeupBoxState extends State<SmeupBox> with SmeupWidgetStateMixin {
  @override
  void dispose() {
    // SmeupWidgetsNotifier.removeWidget(
    //     widget.scaffoldKey.hashCode, widget.smeupBoxModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getBoxComponent(widget.smeupBoxModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupBoxModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupBox: ${snapshot.error} ${snapshot.stackTrace}',
                logType: LogType.error);
            notifyError(context, widget.smeupBoxModel, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return box;
  }

  Future<SmeupWidgetBuilderResponse> _getBoxComponent(
      SmeupBoxModel smeupBoxModel) async {
    Widget children;

    await smeupBoxModel.setData();

    if (!smeupBoxModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'SmeupBox: Dati non disponibili.  (${smeupBoxModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );
      return SmeupWidgetBuilderResponse(smeupBoxModel, SmeupNotAvailable());
    }

    switch (widget.smeupBoxModel.layout) {
      // layout iotready

      // case '1':
      //   children = _getLayout1(smeupBoxModel.data, context);
      //   break;
      // case '2':
      //   children = _getLayout2(smeupBoxModel.data, context);
      //   break;
      // case '3':
      //   children = _getLayout3(smeupBoxModel.data, context);
      //   break;
      // case '4':
      //   children = _getLayout4(smeupBoxModel.data, context);
      //   break;
      // case '5':
      //   children = _getLayout5(smeupBoxModel.data, context);
      //   break;
      // case '6':
      //   children = _getLayout6(smeupBoxModel.data, context);
      //   break;
      // case 'test':
      //   children = _getLayoutTest(smeupBoxModel.data, context);
      //   break;
      // case 'empty':
      //   children = _getLayoutEmpty(context);
      //   break;

      // layouts Smeup
      case '1':
        children = _getLayout1(smeupBoxModel.data, context);
        break;
      case '2':
        children = _getLayout2(smeupBoxModel.data, context);
        break;
      case '3':
        children = _getLayout3(smeupBoxModel.data, context);
        break;
      case '4':
        children = _getLayout4(smeupBoxModel.data, context);
        break;
      case '5':
        children = _getLayout5(smeupBoxModel.data, context);
        break;
      default:
        // SmeupLogService.writeDebugMessage(
        //     'Error SmeupBox layout not available: \'${widget.smeupBoxModel.layout}\'',
        //     logType: LogType.error);
        // children = SmeupNotAvailable();

        SmeupLogService.writeDebugMessage(
            'No layout received. Used default layout',
            logType: LogType.warning);

        children = _getLayoutDefault(smeupBoxModel.data, context);
        break;
    }

    return SmeupWidgetBuilderResponse(smeupBoxModel, children);
  }

  // Widget _getLayoutEmpty(BuildContext context) {
  //   return SizedBox(
  //     height: widget.smeupBoxModel.height,
  //   );
  // }

  // /// Layout1:
  // /// Column:
  // ///   Column:
  // ///     Row:
  // ///       Column
  // ///         data-2
  // ///         data-3
  // ///         data-4
  // ///       Icon
  // ///         data-0
  // ///         data-1
  // ///   Row:
  // ///     data-5
  // ///     data-6
  // Widget _getLayout1(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   Color cardColor =
  //       SmeupUtilities.getColorFromRGB(data[cols[7]], opacity: data[cols[9]]);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           color: cardColor,
  //           child: Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Container(
  //               height: widget.smeupBoxModel.height,
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     flex: 3,
  //                     child: Container(
  //                       child: Column(
  //                         children: [
  //                           Expanded(
  //                             child: Container(
  //                               child: Row(
  //                                 children: [
  //                                   Expanded(
  //                                     child: Container(
  //                                       child: Column(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.spaceEvenly,
  //                                         children: [
  //                                           Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               data[cols[2]],
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             ),
  //                                           ),
  //                                           Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               data[cols[3]],
  //                                               style: TextStyle(fontSize: 14),
  //                                             ),
  //                                           ),
  //                                           Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(data[cols[4]],
  //                                                 style: TextStyle(
  //                                                     fontSize: 12,
  //                                                     color: Colors.black38)),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     padding: EdgeInsets.only(top: 10),
  //                                     child: Align(
  //                                       alignment: Alignment.topCenter,
  //                                       child: Icon(
  //                                         IconData(data[cols[0]],
  //                                             fontFamily: 'MaterialIcons'),
  //                                         color: SmeupUtilities.getColorFromRGB(
  //                                             data[cols[1]]),
  //                                         size: 25,
  //                                       ),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Column(
  //                               children: [
  //                                 Text(
  //                                     data[widget
  //                                         .smeupBoxModel.clientColumns[5]],
  //                                     style: TextStyle(fontSize: 16)),
  //                                 Text(cols[5], style: TextStyle(fontSize: 10)),
  //                               ],
  //                             ),
  //                             Column(
  //                               children: [
  //                                 Text(
  //                                     data[widget
  //                                         .smeupBoxModel.clientColumns[6]],
  //                                     style: TextStyle(fontSize: 16)),
  //                                 Text(cols[6], style: TextStyle(fontSize: 10)),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // /// Layout2:
  // /// Column
  // ///   Column:
  // ///         data-1
  // ///         data-2
  // ///   Row:
  // ///    column
  // ///     data-3
  // ///     data-4
  // ///     Icon
  // ///       data-5
  // ///       data-6
  // Widget _getLayout2(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Container(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   padding: EdgeInsets.only(top: 10),
  //                   child: Column(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 10.0),
  //                         child: Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             data[cols[0]],
  //                             style: TextStyle(
  //                                 fontSize: 16, fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 10.0),
  //                         child: Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             data[cols[1]],
  //                             style: TextStyle(
  //                                 fontSize: 12, color: Colors.black38),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   padding: EdgeInsets.only(top: 20),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 2,
  //                         child: Container(
  //                           padding: EdgeInsets.only(left: 10),
  //                           child: Align(
  //                             alignment: Alignment.centerLeft,
  //                             child: Column(
  //                               children: [
  //                                 Text(data[cols[2]],
  //                                     style: TextStyle(fontSize: 16)),
  //                                 Text(cols[2], style: TextStyle(fontSize: 10)),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                           flex: 1,
  //                           child: Container(
  //                             padding: EdgeInsets.only(top: 5),
  //                             child: Align(
  //                               alignment: Alignment.topCenter,
  //                               child: Align(
  //                                 alignment: Alignment.topRight,
  //                                 child: Icon(
  //                                   IconData(data[cols[3]],
  //                                       fontFamily: 'MaterialIcons'),
  //                                   color: SmeupUtilities.getColorFromRGB(
  //                                       data[cols[4]]),
  //                                   size: 25,
  //                                 ),
  //                               ),
  //                             ),
  //                           ))
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       )),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // /// Layout3:
  // ///   Row:
  // ///    column
  // ///     data-3
  // ///     data-4
  // ///    Icon
  // ///     data-5
  // ///     data-6
  // Widget _getLayout3(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Container(
  //                 child: Row(
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         padding: EdgeInsets.only(top: 10),
  //                         child: Column(
  //                           children: [
  //                             if (cols[0].isNotEmpty)
  //                               Align(
  //                                 alignment: Alignment.centerLeft,
  //                                 child: Text(cols[0],
  //                                     style: TextStyle(
  //                                         fontSize: 12, color: Colors.black38)),
  //                               ),
  //                             if (cols[0].isNotEmpty) SizedBox(height: 5),
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Text(data[cols[0]],
  //                                   style: TextStyle(fontSize: 16)),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                         child: Container(
  //                             child: Container(
  //                       padding: EdgeInsets.only(top: 15),
  //                       child: Align(
  //                         alignment: Alignment.topCenter,
  //                         child: Align(
  //                           alignment: Alignment.topRight,
  //                           child: Icon(
  //                             IconData(data[cols[1]],
  //                                 fontFamily: 'MaterialIcons'),
  //                             color: SmeupUtilities.getColorFromRGB(
  //                                 data[cols[2]],
  //                                 opacity: data[cols[3]]),
  //                             size: data[cols[4]],
  //                           ),
  //                         ),
  //                       ),
  //                     )))
  //                   ],
  //                 ),
  //               ))),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // ///   Row:
  // ///    column
  // ///     data-3
  // ///     data-4
  // ///    Icon
  // ///     data-5
  // ///     data-6
  // Widget _getLayout4(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Container(
  //                 child: Row(
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         padding: EdgeInsets.only(top: 10),
  //                         child: Column(
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Text(data[cols[0]],
  //                                   style: TextStyle(fontSize: 16)),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                         child: Container(
  //                             child: Container(
  //                       padding: EdgeInsets.only(top: 15),
  //                       child: Align(
  //                         alignment: Alignment.topCenter,
  //                         child: Align(
  //                           alignment: Alignment.topRight,
  //                           child: Icon(
  //                             IconData(data[cols[1]],
  //                                 fontFamily: 'MaterialIcons'),
  //                             color: SmeupUtilities.getColorFromRGB(
  //                                 data[cols[2]],
  //                                 opacity: data[cols[3]]),
  //                             size: data[cols[4]],
  //                           ),
  //                         ),
  //                       ),
  //                     )))
  //                   ],
  //                 ),
  //               ))),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // /// Layout5:
  // ///   Row:
  // ///    Icon
  // ///     data-5
  // ///     data-6
  // ///    column
  // ///     data-3
  // ///     data-4

  // Widget _getLayout5(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: Container(
  //                 child: Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(right: 5),
  //                       child: Icon(
  //                         IconData(data[cols[0]], fontFamily: 'MaterialIcons'),
  //                         color: Colors.black38,
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Container(
  //                         padding: EdgeInsets.all(5.0),
  //                         child: Column(
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Text(data[cols[1]],
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.bold)),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Text(data[cols[2]],
  //                                   style: TextStyle(
  //                                       fontSize: 12, color: Colors.black38)),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ))),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // /// Layout6:
  // ///   Row:
  // ///    Icon
  // ///     data-1
  // ///     data-2
  // ///    data-3

  // Widget _getLayout6(dynamic data, BuildContext context) {
  //   final cols = _getColumns(data);

  //   if (data.length > 0) {
  //     return GestureDetector(
  //       onTap: () {
  //         _manageTap(data);
  //       },
  //       child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: Container(
  //                 child: Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(right: 5),
  //                       child: Icon(
  //                         IconData(data[cols[0]], fontFamily: 'MaterialIcons'),
  //                         color: Colors.black38,
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Container(
  //                         padding: EdgeInsets.all(5.0),
  //                         child: Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(data[cols[1]],
  //                               style: TextStyle(
  //                                   fontSize: 16, fontWeight: FontWeight.bold)),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ))),
  //     );
  //   }

  //   SmeupLogService.writeDebugMessage('Error SmeupBox widget not created',
  //       logType: LogType.error);

  //   return SmeupNotAvailable();
  // }

  // /// LayoutTest:
  // /// row:
  // Widget _getLayoutTest(dynamic data, BuildContext context) {
  //   return Container(
  //     child: Text(data['test']),
  //   );
  // }

  /// Layout1:
  ///   Row:
  ///    column
  ///     data-0
  ///     data-1
  Widget _getLayout1(dynamic data, BuildContext context) {
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var widgets = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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
    final cols = widget.smeupBoxModel.clientColumns;

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
                  height: widget.smeupBoxModel.height,
                  child: Row(
                    children: () {
                      var listOfRows = List<Widget>.empty(growable: true);

                      cols.forEach((col) {
                        if (col['IO'] != 'H' &&
                            !widget._excludedColumns.contains(col['ogg'])) {
                          String rowData = data[col['code']];

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

  // List<String> _getColumns(dynamic data) {
  //   var cols = widget.smeupBoxModel.clientColumns;
  //   if (cols == null && data != null && (data as Map).length > 0) {
  //     cols = List<String>.empty(growable: true);
  //     (data as Map).keys.forEach((element) {
  //       cols.add(element);
  //     });
  //   }
  //   return cols;
  // }

  Widget _getImage(dynamic data) {
    Widget widgetImg;
    var colImg = widget.smeupBoxModel.clientColumns.firstWhere(
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

    var buttonCols = widget.smeupBoxModel.clientColumns
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
              smeupButtonsModel: SmeupButtonsModel(
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
                clientData: buttonText,
              ),
              onClientPressed: () {
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
    if (widget.onClientPressed != null) {
      widget.smeupBoxModel.dynamisms = [
        {"event": "click", "exec": ""}
      ];
      SmeupDynamismService.storeDynamicVariables(data);
      widget.onClientPressed();
    } else {
      SmeupDynamismService.storeDynamicVariables(data);
      widget.onServerPressed();
    }
  }
}

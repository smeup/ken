import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_box_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_box_notifier.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widgets_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_box.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';

class SmeupListBox extends StatefulWidget {
  final SmeupListBoxModel smeupListModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function onServerPressed;
  final Function onClientPressed;

  SmeupListBox(this.smeupListModel, this.scaffoldKey, this.formKey,
      {this.onServerPressed, this.onClientPressed});

  @override
  _SmeupListBoxState createState() => _SmeupListBoxState();
}

class _SmeupListBoxState extends State<SmeupListBox> {
  List<Widget> cells;

  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupListModel.id);
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
    if (widget.smeupListModel.isNotified) {
      widget.smeupListModel.isNotified = false;
    }

    final SmeupBoxNotifier notifier = Provider.of<SmeupBoxNotifier>(context,
        listen: widget.smeupListModel.notificationEnabled);
    notifier.classes
        .removeWhere((element) => element['id'] == widget.smeupListModel.id);
    notifier.classes.add({
      'id': widget.smeupListModel.id,
      'model': widget.smeupListModel,
      'notifierFunction': () {
        setState(() {
          SmeupLogService.writeDebugMessage(
              'notified ${widget.smeupListModel.type}: ${widget.smeupListModel.id}',
              logType: LogType.info);
        });
      }
    });

    if (widget.scaffoldKey.hashCode ==
        SmeupDynamismService.currentScaffoldKey.hashCode)
      notifier.setRefresh(widget.smeupListModel.id);

    var boxes = widget.smeupListModel.load == 'D'
        ? Container()
        : FutureBuilder(
            future: _getListComponents(widget.smeupListModel),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return widget.smeupListModel.showLoader
                    ? SmeupWait()
                    : Container();
              } else {
                if (snapshot.hasError) {
                  SmeupLogService.writeDebugMessage(
                      'Error SmeupListBox: ${snapshot.error}',
                      logType: LogType.error);
                  widget.smeupListModel.notifyError(context, snapshot.error);
                  return SmeupNotAvailable();
                } else {
                  return snapshot.data.children;
                }
              }
            },
          );

    if (widget.smeupListModel.notificationEnabled) {
      SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
          widget.smeupListModel.id, widget.smeupListModel.type, notifier);
    }

    return boxes;
  }

  Future<SmeupWidgetBuilderResponse> _getListComponents(
      SmeupListBoxModel smeupListModel) async {
    Widget children;

    await _loadData();
    if (cells == null) {
      return SmeupWidgetBuilderResponse(smeupListModel, SmeupNotAvailable());
    }

    var padding = EdgeInsets.zero;
    if (widget.smeupListModel.padding > 0)
      padding = EdgeInsets.all(widget.smeupListModel.padding);
    if (widget.smeupListModel.paddingRight > 0 ||
        widget.smeupListModel.paddingLeft > 0)
      padding = EdgeInsets.only(
          right: widget.smeupListModel.paddingRight,
          left: widget.smeupListModel.paddingLeft);

    switch (smeupListModel.listType) {
      case SmeupListType.simple:
        children = _getSimpleList(cells, padding);
        break;
      case SmeupListType.oriented:
        children = _getOrientedList(cells, padding);
        break;
      case SmeupListType.wheel:
        break;
      default:
    }

    return SmeupWidgetBuilderResponse(smeupListModel, children);
  }

  Future<void> _loadData() async {
    await widget.smeupListModel.setData();

    if (!widget.smeupListModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${widget.smeupListModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return;
    }

    cells = _getListWidget(context, widget.smeupListModel.data);
  }

  Widget _getSimpleList(List<Widget> cells, EdgeInsets padding) {
    var list;
    if (widget.smeupListModel.orientation == Axis.vertical) {
      list = SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical,
        child: Column(
          children: cells,
        ),
      );
    } else {
      list = SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cells,
        ),
      );
    }

    // double height = 0;
    // if (widget.smeupListModel.orientation == Axis.vertical) {
    //   height = cells.length * widget.smeupListModel.height;
    // } else {
    //   height = widget.smeupListModel.height;
    // }

    final container = Container(
        padding: padding,
        color: Colors.transparent,
        height: widget.smeupListModel.listHeight,
        child: list);

    return container;
  }

  Widget _getOrientedList(List<Widget> cells, EdgeInsets padding) {
    var list;
    list = OrientationBuilder(
      builder: (context, orientation) {
        int col = widget.smeupListModel.portraitColumns;
        if (SmeupOptions.orientation == Orientation.landscape) {
          col = widget.smeupListModel.landscapeColumns;
        }
        return RefreshIndicator(
          onRefresh: _refreshRandomNumbers,
          child: GridView.count(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            scrollDirection: widget.smeupListModel.orientation,
            crossAxisCount: col,
            children: cells,
          ),
        );
      },
    );

    // double height = 0;
    // if (widget.smeupListModel.orientation == Axis.vertical) {
    //   height = cells.length * widget.smeupListModel.height;
    // } else {
    //   height = widget.smeupListModel.height;
    // }

    final container = Container(
        padding: padding,
        color: Colors.transparent,
        height: widget.smeupListModel.listHeight,
        child: list);

    return container;
  }

  Future<void> _refreshRandomNumbers() async {
    //await _loadData();
    setState(() {});
  }

  List<Widget> _getListWidget(BuildContext context, dynamic data) {
    final widgets = List<Widget>.empty(growable: true);

    data['rows'].forEach((dataElement) {
      var boxModel = SmeupBoxModel(
          layout: widget.smeupListModel.boxLayout,
          clientColumns: data['columns'] != null
              ? data['columns']
              : widget.smeupListModel.boxColumnNames,
          height: widget.smeupListModel.height,
          width: widget.smeupListModel.width,
          title: widget.smeupListModel.title,
          //clientOnTap: widget.smeupListModel.boxOnTap,
          clientRow: dataElement);

      final container = Container(
          padding: const EdgeInsets.all(5.0),
          color: Colors.transparent,
          height: widget.smeupListModel.height == 0
              ? double.infinity
              : widget.smeupListModel.height,
          width: widget.smeupListModel.width == 0
              ? double.infinity
              : widget.smeupListModel.width,
          child: SmeupBox(boxModel, widget.scaffoldKey, widget.formKey,
              onClientPressed: widget.onClientPressed, onServerPressed: () {
            SmeupDynamismService.storeDynamicVariables(boxModel.data);

            SmeupDynamismService.run(widget.smeupListModel.dynamisms, context,
                'click', widget.scaffoldKey);
          }));

      widgets.add(container);
    });

    return widgets;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_buttons_notifier.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widgets_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';

class SmeupButtons extends StatefulWidget {
  final SmeupButtonsModel smeupButtonsModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupButtons(
    this.smeupButtonsModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  SmeupButtonsState createState() => SmeupButtonsState();
}

class SmeupButtonsState extends State<SmeupButtons> {
  bool _isBusy;

  @override
  void initState() {
    _isBusy = false;
    super.initState();
  }

  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupButtonsModel.id);
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
    if (widget.smeupButtonsModel.isNotified) {
      widget.smeupButtonsModel.isNotified = false;
    }

    // ignore: unused_local_variable
    final SmeupButtonsNotifier notifier =
        Provider.of<SmeupButtonsNotifier>(context);
    notifier.classes
        .removeWhere((element) => element['id'] == widget.smeupButtonsModel.id);
    notifier.classes.add({
      'id': widget.smeupButtonsModel.id,
      'model': widget.smeupButtonsModel,
      'notifierFunction': () {
        setState(() {
          SmeupLogService.writeDebugMessage(
              'notified ${widget.smeupButtonsModel.type}: ${widget.smeupButtonsModel.id}',
              logType: LogType.info);
        });
      }
    });

    if (widget.scaffoldKey.hashCode ==
        SmeupDynamismService.currentScaffoldKey.hashCode)
      notifier.setRefresh(widget.smeupButtonsModel.id);

    final buttons = widget.smeupButtonsModel.load == 'D'
        ? Container()
        : FutureBuilder<SmeupWidgetBuilderResponse>(
            future: _getButtonsComponent(widget.smeupButtonsModel),
            builder: (BuildContext context,
                AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return widget.smeupButtonsModel.showLoader
                    ? SmeupWait()
                    : Container();
              } else {
                if (snapshot.hasError) {
                  SmeupLogService.writeDebugMessage(
                      'Error SmeupButtons: ${snapshot.error} - ${snapshot.stackTrace}',
                      logType: LogType.error);
                  widget.smeupButtonsModel.notifyError(context, snapshot.error);
                  return SmeupNotAvailable();
                } else {
                  return snapshot.data.children;
                }
              }
            },
          );

    SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
        widget.smeupButtonsModel.id, widget.smeupButtonsModel.type, notifier);
    return buttons;
  }

  Future<SmeupWidgetBuilderResponse> _getButtonsComponent(
      SmeupButtonsModel smeupButtonsModel) async {
    await smeupButtonsModel.setData();

    if (!smeupButtonsModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupButtonsModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupButtonsModel, SmeupNotAvailable());
    }

    var buttons = List<SmeupButton>.empty(growable: true);

    smeupButtonsModel.data.forEach((child) {
      dynamic _child = child;
      SmeupButtonsModel _smeupButtonsModel = smeupButtonsModel;

      if (child is Node) {
        _child = {"p": "", "t": "", "k": child.label};
        _smeupButtonsModel = SmeupButtonsModel.clone(smeupButtonsModel);
        _smeupButtonsModel.clientData = child.label;
        _smeupButtonsModel.dynamisms = [
          {"event": "click", "exec": child.data["exec"] ?? ""}
        ];
      }

      final button = SmeupButton(
          smeupButtonsModel: _smeupButtonsModel,
          data: _child,
          icon: null,
          isBusy: _isBusy,
          onServerPressed: () {
            runDynamism(_smeupButtonsModel, context, child);
          });

      buttons.add(button);
    });

    if (buttons.length > 0) {
      final column = Column(children: buttons);
      return SmeupWidgetBuilderResponse(smeupButtonsModel, column);
    } else {
      SmeupLogService.writeDebugMessage(
          'Error SmeupButtons no children \'button\' created',
          logType: LogType.warning);
      final column = Column(children: [Container()]);
      return SmeupWidgetBuilderResponse(smeupButtonsModel, column);
    }
  }

  void runDynamism(SmeupButtonsModel smeupButtonsModel, BuildContext context,
      dynamic child) async {
    if (_isDinamismAsync(smeupButtonsModel)) {
      execDynamismActions(smeupButtonsModel, child, true);

      SmeupLogService.writeDebugMessage('********************* ASYNC = TRUE',
          logType: LogType.info);
    } else {
      if (_isBusy) {
        SmeupLogService.writeDebugMessage(
            '********************* SKIPPED DOUBLE CLICK',
            logType: LogType.warning);
        return;
      } else {
        SmeupLogService.writeDebugMessage('********************* ASYNC = FALSE',
            logType: LogType.info);

        setState(() {
          _isBusy = true;
        });

        await execDynamismActions(smeupButtonsModel, child, false);

        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  bool _isDinamismAsync(SmeupButtonsModel smeupButtonsModel) {
    return smeupButtonsModel.smeupFun != null
        ? smeupButtonsModel.smeupFun
            .isDinamismAsync(smeupButtonsModel.dynamisms, 'click')
        : false;
  }

  Future<void> execDynamismActions(
      SmeupButtonsModel smeupButtonsModel, dynamic child, bool isAsync) async {
    dynamic _child = child;
    if (child is Node) {
      _child = {
        "t": child.data["tipo"],
        "p": child.data["parametro"],
        "k": child.data["codice"]
      };
    }

    SmeupDynamismService.storeDynamicVariables(_child['content']);

    if (isAsync)
      SmeupDynamismService.run(
          smeupButtonsModel.dynamisms, context, 'click', widget.scaffoldKey);
    else
      await SmeupDynamismService.run(
          smeupButtonsModel.dynamisms, context, 'click', widget.scaffoldKey);
  }
}

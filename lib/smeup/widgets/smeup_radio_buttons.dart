import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_radio_buttons_notifier.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widgets_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';

class SmeupRadioButtons extends StatefulWidget {
  final SmeupRadioButtonsModel smeupRadioButtonsModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupRadioButtons(
    this.smeupRadioButtonsModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  _SmeupRadioButtonsState createState() => _SmeupRadioButtonsState();
}

class _SmeupRadioButtonsState extends State<SmeupRadioButtons> {
  @override
  void initState() {
    SmeupDynamismService.variables[widget.smeupRadioButtonsModel.id] =
        widget.smeupRadioButtonsModel.selectedValue;
    super.initState();
  }

  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupRadioButtonsModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupRadioButtonsNotifier notifier =
        Provider.of<SmeupRadioButtonsNotifier>(context);

    final buttons = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getButtonsComponent(widget.smeupRadioButtonsModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupRadioButtonsModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupRadioButtons: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupRadioButtonsModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    SmeupWidgetsNotifier.addWidget(
        widget.scaffoldKey.hashCode,
        widget.smeupRadioButtonsModel.id,
        widget.smeupRadioButtonsModel.type,
        notifier);
    return buttons;
  }

  Future<SmeupWidgetBuilderResponse> _getButtonsComponent(
      SmeupRadioButtonsModel smeupRadioButtonsModel) async {
    await smeupRadioButtonsModel.setData();

    if (!smeupRadioButtonsModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupRadioButtonsModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupRadioButtonsModel, SmeupNotAvailable());
    }

    var buttons = List<Widget>.empty(growable: true);

    if (smeupRadioButtonsModel.title.isNotEmpty) {
      buttons.add(Container(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          child: Text(
            smeupRadioButtonsModel.title,
            style: TextStyle(
                fontSize: smeupRadioButtonsModel.fontsize,
                color: smeupRadioButtonsModel.fontColor),
          )));
    }

    smeupRadioButtonsModel.data.forEach((child) {
      final button = SmeupRadioButton(
        smeupRadioButtonsModel: smeupRadioButtonsModel,
        data: child,
        icon: null,
        onServerPressed: (value) {
          setState(() {
            dynamic selData = (smeupRadioButtonsModel.data as List).firstWhere(
                (element) => element['k'] == value,
                orElse: () => null);
            if (selData != null) {
              SmeupDynamismService.storeDynamicVariables(selData);
              SmeupDynamismService.variables[smeupRadioButtonsModel.id] = value;
              SmeupDynamismService.run(smeupRadioButtonsModel.dynamisms,
                  context, 'change', widget.scaffoldKey);
            }
          });
        },
        selectedValue:
            SmeupDynamismService.variables[widget.smeupRadioButtonsModel.id],
      );
      SmeupDynamismService.run(smeupRadioButtonsModel.dynamisms, context,
          'change', widget.scaffoldKey);
      buttons.add(button);
    });

    if (buttons.length > 0) {
      final listView = ListView(children: buttons);
      final container = Container(
          padding: smeupRadioButtonsModel.padding > 0
              ? EdgeInsets.all(smeupRadioButtonsModel.padding)
              : EdgeInsets.only(
                  top: smeupRadioButtonsModel.topPadding,
                  bottom: smeupRadioButtonsModel.bottomPadding,
                  right: smeupRadioButtonsModel.rightPadding,
                  left: smeupRadioButtonsModel.leftPadding),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: SmeupOptions.theme.primaryColor)),
              child: listView));

      dynamic selData = (smeupRadioButtonsModel.data as List).firstWhere(
          (element) =>
              element['k'] ==
              SmeupDynamismService.variables[widget.smeupRadioButtonsModel.id],
          orElse: () => null);
      if (selData != null) {
        SmeupDynamismService.storeDynamicVariables(selData);
      }

      return SmeupWidgetBuilderResponse(smeupRadioButtonsModel, container);
    } else {
      SmeupLogService.writeDebugMessage(
          'Error SmeupRadioButtons no children \'button\' created',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(
          smeupRadioButtonsModel, SmeupNotAvailable());
    }
  }
}

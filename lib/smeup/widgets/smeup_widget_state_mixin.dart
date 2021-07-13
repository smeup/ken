import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:provider/provider.dart';

class SmeupWidgetStateMixin {
  Widget runBuild(BuildContext context, SmeupComponentModel model,
      GlobalKey<ScaffoldState> scaffoldKey,
      {Function notifierFunction}) {
    //
    if (notifierFunction != null) {
      final SmeupWidgetNotifier notifier =
          Provider.of<SmeupWidgetNotifier>(context, listen: false);

      notifier.objects.removeWhere((element) => element['id'] == model.id);
      notifier.objects.add({
        'id': model.id,
        'model': model,
        'notifierFunction': notifierFunction
      });

      if (scaffoldKey.hashCode ==
          SmeupDynamismService.currentScaffoldKey.hashCode)
        notifier.setTimerRefresh(model.id);

      SmeupWidgetNotifier.addWidget(
          scaffoldKey.hashCode, model.id, model.type, notifier);
    }

    return model.load == 'D'
        ? Container()
        : FutureBuilder<SmeupWidgetBuilderResponse>(
            future: getChildren(),
            builder: (BuildContext context,
                AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                if (snapshot.hasError) {
                  SmeupLogService.writeDebugMessage(
                      'Error ${model.type}: ${snapshot.error}',
                      logType: LogType.error);
                  model.notifyError(context, snapshot.error);
                  return SmeupNotAvailable();
                } else {
                  return snapshot.data.children;
                }
              }
            },
          );
  }

  Future<SmeupWidgetBuilderResponse> getChildren() {
    //print('getChildren in mixin');
    return Future(() {
      return SmeupWidgetBuilderResponse(null, SmeupNotAvailable());
    });
  }

  Future<SmeupWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, SmeupModel model) {
    return Future(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${model.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );
      return SmeupWidgetBuilderResponse(model, SmeupNotAvailable());
    });
  }

  void runDispose(
      GlobalKey<ScaffoldState> scaffoldKey, SmeupComponentModel model) {
    SmeupWidgetNotifier.removeWidget(scaffoldKey.hashCode, model.id);
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_error_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_widget_notification_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:provider/provider.dart';

class SmeupWidgetStateMixin {
  LoadType widgetLoadType = LoadType.Immediate;

  Widget runBuild(BuildContext context, String id, String type,
      GlobalKey<ScaffoldState> scaffoldKey,
      {Function notifierFunction}) {
    var sel = SmeupWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    if (sel == null) {
      SmeupWidgetNotificationService.objects.add({
        'id': id,
        'dataLoaded': false,
        'scaffoldKey': scaffoldKey.hashCode,
        'notifierFunction': notifierFunction
      });
    } else {
      bool exLoaded = sel['dataLoaded'];
      SmeupWidgetNotificationService.objects
          .removeWhere((element) => element['id'] == id);
      SmeupWidgetNotificationService.objects.add({
        'id': id,
        'dataLoaded': exLoaded,
        'scaffoldKey': scaffoldKey.hashCode,
        'notifierFunction': notifierFunction
      });
    }

    return widgetLoadType == LoadType.Delay
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
                      'Error $type: ${snapshot.error}',
                      logType: LogType.error);
                  notifyError(context, id, snapshot.error);
                  return SmeupNotAvailable();
                } else {
                  return snapshot.data.children;
                }
              }
            },
          );
  }

  bool getDataLoaded(id) {
    final sel = SmeupWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    return sel['dataLoaded'];
  }

  void setDataLoad(String id, bool value) {
    var sel = SmeupWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    sel['dataLoaded'] = value;
    SmeupWidgetNotificationService.objects
        .removeWhere((element) => element['id'] == id);
    SmeupWidgetNotificationService.objects.add(sel);
  }

  Future<SmeupWidgetBuilderResponse> getChildren() {
    //print('getChildren in mixin');
    return Future(() {
      return SmeupWidgetBuilderResponse(null, SmeupNotAvailable());
    });
  }

  void notifyError(context, String id, Object error) {
    final SmeupErrorNotifier errorNotifier =
        Provider.of<SmeupErrorNotifier>(context, listen: false);

    if (!errorNotifier.isError()) {
      errorNotifier.setError(true);
      SmeupLogService.writeDebugMessage('Notified error: $id',
          logType: LogType.error);
      Future.delayed(Duration(seconds: 1), () async {
        errorNotifier.notifyError();
      });
    }
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

  void runDispose(GlobalKey<ScaffoldState> scaffoldKey, String id) {}

  bool hasSections(SmeupModel model) {
    return model.smeupSectionsModels != null &&
        model.smeupSectionsModels.length > 0;
  }

  bool hasData(SmeupModel model) {
    return model.data != null;
  }
}

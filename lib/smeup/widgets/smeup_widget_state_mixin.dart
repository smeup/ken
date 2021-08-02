import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_error_notifier.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:provider/provider.dart';

class SmeupWidgetStateMixin {
  LoadType widgetLoadType = LoadType.Immediate;

  SmeupWidgetNotifier notifier;

  Widget runBuild(BuildContext context, String id, String type,
      GlobalKey<ScaffoldState> scaffoldKey,
      {Function notifierFunction}) {
    notifier = Provider.of<SmeupWidgetNotifier>(context, listen: false);

    var sel = notifier.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    if (sel == null) {
      notifier.objects.add(
          {'id': id, 'dataLoaded': true, 'notifierFunction': notifierFunction});
    } else {
      bool exLoaded = sel['dataLoaded'];
      notifier.objects.removeWhere((element) => element['id'] == id);
      notifier.objects.add({
        'id': id,
        'dataLoaded': exLoaded,
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
    final sel = notifier.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    return sel['dataLoaded'];
  }

  void setDataLoad(String id, bool value) {
    var sel = notifier.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    sel['dataLoaded'] = value;
    notifier.objects.removeWhere((element) => element['id'] == id);
    notifier.objects.add(sel);
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
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //         'Dati non disponibili.  (${model.smeupFun.fun['fun']['function']})'),
      //     backgroundColor: SmeupOptions.theme.errorColor,
      //   ),
      // );
      return SmeupWidgetBuilderResponse(model, SmeupNotAvailable());
    });
  }

  void runDispose(GlobalKey<ScaffoldState> scaffoldKey, String id) {
    //SmeupWidgetNotifier.removeWidget(scaffoldKey.hashCode, id);
    //notifier.objects.removeWhere((element) => element['id'] == id);
  }

  // TODO: pass the section instead
  bool hasSections(SmeupModel model) {
    return model.smeupSectionsModels != null &&
        model.smeupSectionsModels.length > 0;
  }

  // TODO: pass the data instead
  bool hasData(SmeupModel model) {
    return model.data != null;
  }
}

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/notifiers/ken_error_notifier.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_localization_service.dart';
import 'package:ken/smeup/services/ken_widget_notification_service.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/widgets/kenNotAvailable.dart';
import 'package:provider/provider.dart';
import '../services/ken_configuration_service.dart';

mixin KenWidgetStateMixin {
  LoadType widgetLoadType = LoadType.Immediate;

  Widget runBuild(BuildContext context, String? id, String? type,
      GlobalKey<ScaffoldState>? scaffoldKey, bool initialDataLoad,
      {Function? notifierFunction}) {
    var sel = KenWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    if (sel == null) {
      KenWidgetNotificationService.objects.add({
        'id': id,
        'dataLoaded': initialDataLoad,
        'scaffoldKey': scaffoldKey.hashCode,
        'notifierFunction': notifierFunction
      });
    } else {
      bool? exLoaded = sel['dataLoaded'];
      KenWidgetNotificationService.objects
          .removeWhere((element) => element['id'] == id);
      KenWidgetNotificationService.objects.add({
        'id': id,
        'dataLoaded': exLoaded,
        'scaffoldKey': scaffoldKey.hashCode,
        'notifierFunction': notifierFunction
      });
    }

    return widgetLoadType == LoadType.Delay
        ? Container()
        : FutureBuilder<KenWidgetBuilderResponse>(
            future: getChildren(),
            builder: (BuildContext context,
                AsyncSnapshot<KenWidgetBuilderResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                if (snapshot.hasError) {
                  KenLogService.writeDebugMessage(
                      'Error $type: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                      logType: KenLogType.error);
                  notifyError(context, id, snapshot.error);
                  return KenNotAvailable();
                } else {
                  return snapshot.data!.children!;
                }
              }
            },
          );
  }

  bool? getDataLoaded(id) {
    final sel = KenWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    return sel['dataLoaded'];
  }

  void setDataLoad(String? id, bool value) {
    var sel = KenWidgetNotificationService.objects
        .firstWhere((element) => element['id'] == id, orElse: () => null);
    sel['dataLoaded'] = value;
    KenWidgetNotificationService.objects
        .removeWhere((element) => element['id'] == id);
    KenWidgetNotificationService.objects.add(sel);
  }

  Future<KenWidgetBuilderResponse> getChildren() {
    //print('getChildren in mixin');
    return Future(() {
      return KenWidgetBuilderResponse(null, KenNotAvailable());
    });
  }

  void notifyError(context, String? id, Object? error) {
    final KenErrorNotifier errorNotifier =
        Provider.of<KenErrorNotifier>(context, listen: false);

    if (!errorNotifier.isError()) {
      errorNotifier.setError(true);
      KenLogService.writeDebugMessage('Notified error: $id',
          logType: KenLogType.error);
      Future.delayed(Duration(seconds: 1), () async {
        errorNotifier.notifyError();
      });
    }
  }

  Future<KenWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, KenModel? model) {
    return Future(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${KenLocalizationService.of(context)!.getLocalString('dataNotAvailable')}.  (${model == null ? '' : model.smeupFun!.identifier.function})'),
          backgroundColor:
              KenConfigurationService.getTheme()!.colorScheme.error,
        ),
      );
      return KenWidgetBuilderResponse(model, KenNotAvailable());
    });
  }

  void runDispose(GlobalKey<ScaffoldState>? scaffoldKey, String? id) {}

  bool hasSections(KenSectionModel model) {
    return model.smeupSectionsModels != null &&
        model.smeupSectionsModels!.length > 0;
  }

  bool hasData(KenModel model) {
    return model.data != null;
  }

  /// return the information if data has been loaded
  /// static constructor: always false (because in this case the widget will receive the data directly)
  /// dynamic constrctor: true if the model is not null and contains data
  bool getInitialdataLoaded(KenModel? model) {
    return (model != null && model.data != null) || model == null;
  }
}

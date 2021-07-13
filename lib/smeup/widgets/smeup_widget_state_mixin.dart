import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';

class SmeupWidgetStateMixin {
  Widget runBuild(BuildContext context, SmeupComponentModel model) {
    return FutureBuilder<SmeupWidgetBuilderResponse>(
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
}

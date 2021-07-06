import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_model_mixin.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_error_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupComponentModel extends SmeupModel with SmeupModelMixin {
  bool loaded = false;

  List<SmeupSectionModel> smeupSectionsModels;

  SmeupComponentModel({title}) : super(title: title);

  SmeupComponentModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    loaded = jsonMap['loaded'];
    data = jsonMap['data'];
    layout = jsonMap['layout'];
  }

  Alignment getAlignmentGeometry(String alignment) {
    switch (alignment) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      case "center":
        return Alignment.center;
      // case "topLeft":
      //   return Alignment.topLeft;
      // case "topRight":
      //   return Alignment.topRight;
      case "top":
        return Alignment.topCenter;
      // case "bottomLeft":
      //   return Alignment.bottomLeft;
      // case "bottomRight":
      //   return Alignment.bottomRight;
      case "bottom":
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }

  MainAxisAlignment getMainAxisAlignment(String position) {
    switch (position) {
      case "center":
        return MainAxisAlignment.center;
      case "start":
        return MainAxisAlignment.start;
      case "end":
        return MainAxisAlignment.end;
      case "spaceAround":
        return MainAxisAlignment.spaceAround;
      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;
      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.center;
    }
  }

  bool hasSections() {
    return smeupSectionsModels != null && smeupSectionsModels.length > 0;
  }

  void notifyError(context, Object error) {
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
}

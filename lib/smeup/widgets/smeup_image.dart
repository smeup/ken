import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

class SmeupImage extends StatelessWidget with SmeupWidgetStateMixin {
  final SmeupImageModel smeupImageModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupImage(
    this.smeupImageModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  Widget build(BuildContext context) {
    final box = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getUserImage(this.smeupImageModel, context),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return this.smeupImageModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupImage: ${snapshot.error}',
                logType: LogType.error);
            notifyError(context, smeupImageModel, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return box;
  }

  Future<SmeupWidgetBuilderResponse> _getUserImage(
      SmeupImageModel smeupImageModel, BuildContext context) async {
    Widget container;

    try {
      await smeupImageModel.setData();

      if (!hasData(smeupImageModel)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Dati non disponibili.  (${smeupImageModel.smeupFun.fun['fun']['function']})'),
            backgroundColor: SmeupOptions.theme.errorColor,
          ),
        );

        return SmeupWidgetBuilderResponse(smeupImageModel, SmeupNotAvailable());
      }

      var image;
      if (smeupImageModel.data['imageLocalPath'] != null) {
        image = Image.asset(
          smeupImageModel.data['imageLocalPath'],
          height: smeupImageModel.height,
          width: smeupImageModel.width,
        );
      } else {
        image = Image.network(
          smeupImageModel.data['imageRemotePath'],
          height: smeupImageModel.height,
          width: smeupImageModel.width,
        );
      }
      container = Container(
        padding: getPadding(smeupImageModel),
        child: image,
      );
    } catch (e) {
      container = SmeupNotAvailable(
          height: smeupImageModel.height, width: smeupImageModel.width);
    }

    return SmeupWidgetBuilderResponse(smeupImageModel, container);
  }

  EdgeInsets getPadding(SmeupImageModel smeupImageModel) {
    return smeupImageModel.padding > 0
        ? EdgeInsets.all(smeupImageModel.padding)
        : EdgeInsets.only(
            top: smeupImageModel.topPadding,
            bottom: smeupImageModel.bottomPadding,
            right: smeupImageModel.rightPadding,
            left: smeupImageModel.leftPadding);
  }
}

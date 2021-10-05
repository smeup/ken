import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'smeup_not_available.dart';

class SmeupQRCodeReader extends StatefulWidget {
  final SmeupQRCodeReaderModel smeupQRCodeReaderModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupQRCodeReader(
      this.smeupQRCodeReaderModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupQRCodeReaderState createState() => _SmeupQRCodeReaderState();
}

class _SmeupQRCodeReaderState extends State<SmeupQRCodeReader>
    with SmeupWidgetStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getQRCodeComponent(widget.smeupQRCodeReaderModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupQRCodeReaderModel.showLoader
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupQRCodeReader: ${snapshot.error}',
                logType: LogType.error);
            notifyError(
                context, widget.smeupQRCodeReaderModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getQRCodeComponent(
      SmeupQRCodeReaderModel smeupQRCodeReaderModel) async {
    Widget children;

    await smeupQRCodeReaderModel.setData();

    if (!hasData(smeupQRCodeReaderModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${SmeupLocalizationService.of(context).getLocalString('dataNotAvailable')}.  (${smeupQRCodeReaderModel.smeupFun?.fun['fun']['function']})'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupQRCodeReaderModel, SmeupNotAvailable());
    }

    children = Center(
      child: Container(
        padding: EdgeInsets.all(smeupQRCodeReaderModel.padding),
        child: QrImage(
          data: smeupQRCodeReaderModel.data['rows'][0]['QRC'],
          size: smeupQRCodeReaderModel.size,
          errorCorrectionLevel: QrErrorCorrectLevel.Q,
          gapless: false,
          version: 9,
        ),
      ),
    );

    return SmeupWidgetBuilderResponse(smeupQRCodeReaderModel, children);
  }
}

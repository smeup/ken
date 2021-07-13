import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';
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

class _SmeupQRCodeReaderState extends State<SmeupQRCodeReader> {
  @override
  void dispose() {
    // SmeupWidgetsNotifier.removeWidget(
    //     widget.scaffoldKey.hashCode, widget.smeupQRCodeReaderModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupWidgetNotifier notifier =
        Provider.of<SmeupWidgetNotifier>(context);

    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getQRCodeComponent(widget.smeupQRCodeReaderModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupQRCodeReaderModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupQRCodeReader: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupQRCodeReaderModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(
    //     widget.scaffoldKey.hashCode,
    //     widget.smeupQRCodeReaderModel.id,
    //     widget.smeupQRCodeReaderModel.type,
    //     notifier);

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getQRCodeComponent(
      SmeupQRCodeReaderModel smeupQRCodeReaderModel) async {
    Widget children;

    await smeupQRCodeReaderModel.setData();

    if (!smeupQRCodeReaderModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupQRCodeReaderModel.smeupFun?.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
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

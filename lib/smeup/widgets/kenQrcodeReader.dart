import 'package:flutter/material.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_defaults.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KenQRCodeReader extends StatelessWidget {
  double? padding;
  double? size;
  Function? onDataRead;
  int? maxReads;
  int? delayInMillis;
  bool? showLoader;

  String? id;
  String? type;
  String? data;

  KenQRCodeReader(
      {super.key,
      this.id = '',
      this.type = 'QRC',
      this.data,
      this.padding = KenQRCodeReaderDefaults.defaultPadding,
      this.size = KenQRCodeReaderDefaults.defaultSize,
      this.maxReads = KenQRCodeReaderDefaults.defaultMaxReads,
      this.delayInMillis = KenQRCodeReaderDefaults.defaultDealyInMillis,
      title = ''});

  @override
  Widget build(BuildContext context) {
    Widget children;

    return Center(
      child: Container(
        padding: EdgeInsets.all(padding!),
        child: QrImageView(
          data: data!,
          size: size,
          errorCorrectionLevel: QrErrorCorrectLevel.Q,
          gapless: false,
          version: 9,
          foregroundColor:
              KenConfigurationService.getTheme()!.textTheme.bodyText2!.color,
        ),
      ),
    );
  }
}

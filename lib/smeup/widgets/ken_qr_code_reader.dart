import 'package:flutter/material.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_defaults.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KenQRCodeReader extends StatelessWidget {
  final double? padding;
  final double? size;
  final Function? onDataRead;
  final int? maxReads;
  final int? delayInMillis;
  final bool? showLoader;

  final String? id;
  final String? type;
  final String? data;

  const KenQRCodeReader(
      {super.key,
      this.id = '',
      this.type = 'QRC',
      this.data,
      this.padding = KenQRCodeReaderDefaults.defaultPadding,
      this.size = KenQRCodeReaderDefaults.defaultSize,
      this.maxReads = KenQRCodeReaderDefaults.defaultMaxReads,
      this.delayInMillis = KenQRCodeReaderDefaults.defaultDealyInMillis,
      title = '',
      this.onDataRead,
      this.showLoader});

  @override
  Widget build(BuildContext context) {
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

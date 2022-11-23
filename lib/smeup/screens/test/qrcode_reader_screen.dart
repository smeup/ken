import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_qrcode_reader.dart';

import '../../services/ken_theme_configuration_service.dart';

class QrCodeReaderScreen extends StatelessWidget {
  static const routeName = '/QrCodeReaderScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('QrCode Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    KenQRCodeReader(_scaffoldKey, _formKey,
                        data: 'I am a qrcode', id: 'qrc1'),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

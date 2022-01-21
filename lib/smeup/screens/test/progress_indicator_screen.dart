import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_progress_indicator.dart';

class ProgressIndicatorScreen extends StatelessWidget {
  static const routeName = '/ProgressIndicatorScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ProgressIndicator Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupProgressIndicator(
                      _scaffoldKey,
                      _formKey,
                      id: 'pgi1',
                      size: 200,
                    )
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

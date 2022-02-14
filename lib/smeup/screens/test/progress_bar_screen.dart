import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_progress_bar.dart';

class ProgressBarScreen extends StatelessWidget {
  static const routeName = '/ProgressBarScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const description =
      'Highly customizable, feature-packed progress bar widget for Flutter';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ProgressBar')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(
                        _scaffoldKey, _formKey, description),
                    SmeupProgressBar(
                      _scaffoldKey,
                      _formKey,
                      id: 'pgb1',
                      data: 6,
                      height: 40,
                      progressBarMinimun: 0,
                      progressBarMaximun: 10,
                      padding: EdgeInsets.only(top: 30, left: 5, right: 5),
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

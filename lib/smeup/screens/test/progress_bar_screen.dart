import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_progress_bar.dart';

class ProgressBarScreen extends StatelessWidget {
  static const routeName = '/ProgressBarScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ProgressBar Screen')),
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
                    SmeupProgressBar(
                      _scaffoldKey,
                      _formKey,
                      id: 'pgb1',
                      data: 5,
                      height: 30,
                      progressBarMinimun: 0,
                      progressBarMaximun: 10,
                      padding: EdgeInsets.only(left: 5, right: 5),
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

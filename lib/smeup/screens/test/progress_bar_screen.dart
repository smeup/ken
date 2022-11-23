import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_progress_bar.dart';

import '../../services/ken_theme_configuration_service.dart';

class ProgressBarScreen extends StatelessWidget {
  static const routeName = '/ProgressBarScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const description =
      'A progress bar is a graphical control element used to show the progress of a task';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ProgressBar')),
            actions: ShowCaseShared.getEmptyAction(),
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
                    KenProgressBar(
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

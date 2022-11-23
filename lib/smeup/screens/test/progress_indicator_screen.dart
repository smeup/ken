import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_progress_indicator.dart';

import '../../services/ken_theme_configuration_service.dart';

class ProgressIndicatorScreen extends StatelessWidget {
  static const routeName = '/ProgressIndicatorScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ProgressIndicator Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'Animated progress indicators for Flutter'),
                  KenProgressIndicator(_scaffoldKey, _formKey,
                      id: 'pgi1', size: 200)
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

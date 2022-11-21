import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_splash.dart';

import '../../services/ken_theme_configuration_service.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Splash Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: KenSplash(
            _scaffoldKey,
            _formKey,
            id: 'splash1',
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

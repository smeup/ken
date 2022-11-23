import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_splash.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Splash Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SmeupSplash(
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

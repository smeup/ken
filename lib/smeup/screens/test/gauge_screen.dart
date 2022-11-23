import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_gauge.dart';

import '../../services/ken_theme_configuration_service.dart';

class GaugeScreen extends StatelessWidget {
  static const routeName = '/GaugeScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Gauge')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'The Gauge is a visual element that helps to quickly visualize where a value falls on the axis'),
                  KenGauge(_scaffoldKey, _formKey,
                      id: 'gau1',
                      value: 120,
                      maxValue: 150,
                      minValue: 50,
                      warning: 100,
                      alert: 110),
                ],
              )),
              //),
            ),
          ),
        ),
      ),
    );
  }
}

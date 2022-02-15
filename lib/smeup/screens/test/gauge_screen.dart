import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_gauge.dart';

class GaugeScreen extends StatelessWidget {
  static const routeName = '/GaugeScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Gauge Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                        'The Gauge is a visual element that helps to quickly visualize where a value falls on the axis'),
                    SmeupGauge(
                      _scaffoldKey,
                      _formKey,
                      id: 'gau1',
                      value: 120,
                      maxValue: 150,
                      minValue: 50,
                      warning: 100,
                    ),
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

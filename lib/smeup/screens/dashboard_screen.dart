import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_dashboard.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/DashboardScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Dashboard Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupDashboard(
                      _scaffoldKey,
                      _formKey,
                      15.86,
                      text: 'Dashboard 1',
                      fontSize: 60.0,
                      captionFontSize: 20,
                      icon: 59191,
                      iconSize: 40,
                      iconColor: Colors.green,
                      width: 300,
                      id: 'dashboard1',
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

import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_line.dart';

class LineScreen extends StatelessWidget {
  static const routeName = '/LineScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('List Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SmeupLine(
                  _scaffoldKey,
                  _formKey,
                  id: 'lin1',
                  color: Colors.black,
                  thickness: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                SmeupLine(
                  _scaffoldKey,
                  _formKey,
                  id: 'lin2',
                  color: Colors.red,
                  thickness: 8,
                ),
                SizedBox(
                  height: 10,
                ),
                SmeupLine(
                  _scaffoldKey,
                  _formKey,
                  id: 'lin3',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

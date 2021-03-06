import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_radio_buttons.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class RadioScreen extends StatelessWidget {
  static const routeName = '/RadioScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Radio button Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              // child: Padding(
              //   padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'The Radio Button is used to select between a number of mutually exclusive values'),
                  SmeupRadioButtons(
                    _scaffoldKey,
                    _formKey,
                    title: '',
                    data: [
                      {"code": "1", "value": "Yes"},
                      {"code": "0", "value": "No"},
                      {"code": "2", "value": "Don't know"},
                      {"code": "3", "value": "Maybe"}
                    ],
                    id: 'radio_buttons_1',
                    clientOnPressed: (String value) {
                      SmeupUtilities.invokeScaffoldMessenger(context,
                          "You have changed the radiobutton to: $value");
                    },
                    selectedValue: '0',
                  ),
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

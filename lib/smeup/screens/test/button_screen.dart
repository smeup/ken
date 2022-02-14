import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ButtonScreen extends StatelessWidget {
  static const routeName = '/ButtonScreen';
  static const description =
      'Highly customizable, feature-packed button widget for Flutter';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Button')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  SmeupButtons(
                    _scaffoldKey,
                    _formKey,
                    //width: double.infinity,
                    id: 'buttons_1',
                    data: ['Button'],
                    height: 80,
                    width: 260,
                    iconData: 62371,
                    iconSize: 25,
                    borderRadius: 30,
                    fontSize: 18,
                    backColor: Color.fromRGBO(6, 140, 154, 10),
                    fontColor: Colors.white,
                    align: Alignment.centerRight,
                    clientOnPressed: (buttonIndex, buttonText) {
                      SmeupUtilities.invokeScaffoldMessenger(context,
                          "You have clicked the button with text \"$buttonText\" ");
                    },
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

import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';

class DialogScreen extends StatelessWidget {
  static const routeName = '/DialogScreen';
  static const description =
      'The dialog comes on a separated window or screen which contains any critical information or can ask for any decision';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Dialog')),
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
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'Tap the button below to open an example dialog'),
                  SmeupButtons(
                    _scaffoldKey,
                    _formKey,
                    //width: double.infinity,
                    id: 'buttons_1',
                    data: ['Open the dialog'],
                    iconSize: 25,
                    borderRadius: 30,
                    fontSize: 18,
                    backColor: Color.fromRGBO(6, 140, 154, 10),
                    fontColor: Colors.white,
                    align: Alignment.centerRight,
                    clientOnPressed: (buttonIndex, buttonText) {
                      SmeupUtilities.invokeScaffoldMessenger(context,
                          "You have clicked the button with text \"$buttonText\" ");

                      SmeupDynamismService.run([
                        {
                          "event": "click",
                          "exec":
                              "F(EXD;*JSN;) 1(;;packages/ken/assets/jsons/forms) 2(;;dialog_form) P(DIALOG) G(DLG) "
                        }
                      ], context, 'click', _scaffoldKey, _formKey);
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

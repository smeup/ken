import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ButtonScreen extends StatelessWidget {
  static const routeName = '/ButtonScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Button Screen')),
            ),
            body: Column(
              children: [
                SmeupButtons(
                  _scaffoldKey,
                  _formKey,
                  width: double.infinity,
                  id: 'buttons_1',
                  data: ['I am a button', 'I am a button too'],
                  backColor: Colors.red,
                  fontColor: Colors.black,
                  align: Alignment.center,
                  clientOnPressed: (buttonIndex, buttonText) {
                    SmeupUtilities.invokeScaffoldMessenger(context,
                        "You have clicked the button with text \"$buttonText\" ");
                  },
                ),
                SizedBox(height: 10),
                SmeupButtons(
                  _scaffoldKey,
                  _formKey,
                  width: double.infinity,
                  id: 'buttons_2',
                  data: ['I am a link', 'I am a link too'],
                  isLink: true,
                  clientOnPressed: (buttonIndex, buttonText) {
                    SmeupUtilities.invokeScaffoldMessenger(context,
                        "You have clicked the button with text \"$buttonText\" ");
                  },
                ),
                SmeupButtons(
                  _scaffoldKey,
                  _formKey,
                  width: double.infinity,
                  id: 'buttons_3',
                  data: ['Horizontal'],
                  backColor: Colors.blue,
                  fontColor: Colors.white,
                  align: Alignment.center,
                  clientOnPressed: (buttonIndex, buttonText) {
                    SmeupUtilities.invokeScaffoldMessenger(context,
                        "You have clicked the button with text \"$buttonText\" ");
                  },
                ),
                SmeupButtons(
                  _scaffoldKey,
                  _formKey,
                  width: 60,
                  iconData: 62370,
                  id: 'buttons_4',
                  data: ['Small button'],
                  align: Alignment.centerRight,
                  clientOnPressed: (buttonIndex, buttonText) {
                    SmeupUtilities.invokeScaffoldMessenger(context,
                        "You have clicked the button with text \"$buttonText\" ");
                  },
                ),
                SmeupButtons(
                  _scaffoldKey,
                  _formKey,
                  width: 500,
                  iconData: 62751,
                  id: 'buttons_5',
                  data: ['Big button'],
                  align: Alignment.centerLeft,
                  clientOnPressed: (buttonIndex, buttonText) {
                    SmeupUtilities.invokeScaffoldMessenger(context,
                        "You have clicked the button with text \"$buttonText\" ");
                  },
                ),
              ],
            )),
      ),
    );
  }
}

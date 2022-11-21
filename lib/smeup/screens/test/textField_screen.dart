import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_text_field.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class TextFieldScreen extends StatelessWidget {
  static const routeName = '/TextFieldScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('TextField Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'A text field lets the user enter text and perform validation on it. It is also possible to add a submit button',
                      height: 30),
                  KenTextField(
                    _scaffoldKey,
                    _formKey,
                    label: 'description',
                    id: 'text1',
                    data: 'some text',
                    showSubmit: true,
                    submitLabel: 'tap me',
                    clientOnChange: (value) {
                      KenUtilities.invokeScaffoldMessenger(
                          context, 'value changed $value');
                    },
                    clientOnSave: (value) {
                      KenUtilities.invokeScaffoldMessenger(
                          context, 'value saved $value');
                    },
                    clientOnSubmit: (buttonIndex, buttonText) {
                      KenUtilities.invokeScaffoldMessenger(context,
                          'you tapped the submit button "$buttonText"');
                    },
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

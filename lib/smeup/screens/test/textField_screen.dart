import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_text_field.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class TextFieldScreen extends StatelessWidget {
  static const routeName = '/TextFieldScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('TextField Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupTextField(
                      _scaffoldKey,
                      _formKey,
                      label: 'description',
                      id: 'text1',
                      data: 'I am a textfield',
                      showSubmit: true,
                      submitLabel: 'tap me',
                      clientOnChange: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value changed $value');
                      },
                      clientOnSave: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value saved $value');
                      },
                      clientOnSubmit: (buttonIndex, buttonText) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'you tapped the button "$buttonText"');
                      },
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

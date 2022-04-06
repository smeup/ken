import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_text_password.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class TextPasswordScreen extends StatelessWidget {
  static const routeName = '/TextPasswordScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('TextField Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    Text('simple password'),
                    SmeupTextPassword(
                      _scaffoldKey,
                      _formKey,
                      label: 'password 1',
                      id: 'password1',
                      showRules: false,
                      clientOnChange: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value changed $value');
                      },
                      clientOnSave: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value saved $value');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('password with rules'),
                    SmeupTextPassword(
                      _scaffoldKey,
                      _formKey,
                      label: 'password 1',
                      id: 'password2',
                      clientOnChange: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value changed $value');
                      },
                      clientOnSave: (value) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'value saved $value');
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

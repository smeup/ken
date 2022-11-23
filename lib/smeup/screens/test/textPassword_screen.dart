import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_text_password.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class TextPasswordScreen extends StatelessWidget {
  static const routeName = '/TextPasswordScreen';
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
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    Text('simple password'),
                    KenTextPassword(
                      _scaffoldKey,
                      _formKey,
                      label: 'password 1',
                      id: 'password1',
                      showRules: false,
                      clientOnChange: (value) {
                        KenUtilities.invokeScaffoldMessenger(
                            context, 'value changed $value');
                      },
                      clientOnSave: (value) {
                        KenUtilities.invokeScaffoldMessenger(
                            context, 'value saved $value');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('password with rules'),
                    KenTextPassword(
                      _scaffoldKey,
                      _formKey,
                      label: 'password 1',
                      id: 'password2',
                      clientOnChange: (value) {
                        KenUtilities.invokeScaffoldMessenger(
                            context, 'value changed $value');
                      },
                      clientOnSave: (value) {
                        KenUtilities.invokeScaffoldMessenger(
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

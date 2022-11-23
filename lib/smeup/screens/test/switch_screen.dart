import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_switch.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class SwitchScreen extends StatelessWidget {
  static const routeName = '/SwitchScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Switch button Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'A Switch is used to toggle a setting between on/off which is true/false respectively'),
                  KenSwitch(
                    _scaffoldKey,
                    _formKey,
                    text: 'Turn me on/off',
                    data: true,
                    id: 'switch1',
                    width: 400,
                    height: 50,
                    captionFontSize: 20,
                    onClientChange: (value) {
                      KenUtilities.invokeScaffoldMessenger(
                          context, "You have changed the switch to: $value");
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

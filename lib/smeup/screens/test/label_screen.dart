import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_label.dart';
import '../../services/ken_theme_configuration_service.dart';

class LabelScreen extends StatelessWidget {
  static const routeName = '/LabelScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Label')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                        'The label has the function to show a not editable descriptive text'),
                    KenLabel(
                      _scaffoldKey,
                      _formKey,
                      ['Information'],
                      id: 'lab2',
                      fontBold: false,
                      align: Alignment.centerRight,
                      iconCode: "0xf51f",
                      fontSize: 30,
                      iconSize: 40,
                      iconColor: Colors.black,
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

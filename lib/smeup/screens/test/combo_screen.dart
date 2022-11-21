import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/ken_combo.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/models/widgets/ken_combo_item_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_theme_configuration_service.dart';

class ComboScreen extends StatelessWidget {
  static const routeName = '/ComboScreen';
  static const description =
      'The combo widget allows you to select a single value from a list';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Combo')),
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
                  KenCombo(
                    _scaffoldKey,
                    _formKey,
                    id: 'combo1',
                    selectedValue: '1',
                    innerSpace: 10,
                    width: 0,
                    padding: EdgeInsets.only(left: 10),
                    label: "City: ",
                    showBorder: true,
                    data: [
                      KenComboItemModel('1', 'Antwerp'),
                      KenComboItemModel('2', 'Boston'),
                      KenComboItemModel('3', 'Milan'),
                      KenComboItemModel('4', 'Paris')
                    ],
                    clientOnChange: (value) {
                      KenUtilities.invokeScaffoldMessenger(
                          context, "You have changed the combo to: $value");
                    },
                  ),
                  SizedBox(
                    height: 10,
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

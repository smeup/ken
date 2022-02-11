import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_combo.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ComboScreen extends StatelessWidget {
  static const routeName = '/ComboScreen';
  static const description =
      'flutter combo widget example. When opened, allow you to select a city';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Combo')),
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
                  SmeupCombo(
                    _scaffoldKey,
                    _formKey,
                    id: 'combo1',
                    selectedValue: '1',
                    label: "City",
                    data: [
                      SmeupComboItemModel('1', 'Antwerp'),
                      SmeupComboItemModel('2', 'Boston'),
                      SmeupComboItemModel('3', 'Milan'),
                      SmeupComboItemModel('4', 'Paris')
                    ],
                    clientOnChange: (value) {
                      SmeupUtilities.invokeScaffoldMessenger(
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

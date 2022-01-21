import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_combo.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ComboScreen extends StatelessWidget {
  static const routeName = '/ComboScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Combo Screen')),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SmeupCombo(
                  _scaffoldKey,
                  _formKey,
                  id: 'combo1',
                  selectedValue: '1',
                  label: "My combo",
                  data: [
                    SmeupComboItemModel('1', 'One'),
                    SmeupComboItemModel('2', 'Two'),
                    SmeupComboItemModel('3', 'Free'),
                    SmeupComboItemModel('4', 'Four')
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
            ),
          ),
        ),
      ),
    );
  }
}

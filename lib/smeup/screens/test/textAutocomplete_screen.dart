import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_label.dart';
import 'package:ken/smeup/widgets/smeup_text_autocomplete.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class TextAutocompleteScreen extends StatelessWidget {
  static const routeName = '/TextAutocompleteScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Autocomplete')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                child: Center(
                    child: Column(
                  children: [
                    SmeupLabel(_scaffoldKey, _formKey,
                        ['Esempio di componente autocompleate']),
                    SmeupTextAutocomplete(
                      _scaffoldKey,
                      _formKey,
                      label: 'description',
                      padding: EdgeInsets.only(left: 10, right: 10),
                      id: 'autocomplete1',
                      valueField: "value",
                      data: [
                        {
                          "code": "1",
                          "value": "Bari",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "2",
                          "value": "Brescia",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "3",
                          "value": "Como",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "4",
                          "value": "Firenze",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "5",
                          "value": "Milano",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "6",
                          "value": "Napoli",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "7",
                          "value": "Venezia",
                          "type": "",
                          "parameter": ""
                        }
                      ],
                      clientOnSelected: (option) {
                        SmeupUtilities.invokeScaffoldMessenger(context,
                            'selected code: ${option['code']}, value: ${option['value']}');
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

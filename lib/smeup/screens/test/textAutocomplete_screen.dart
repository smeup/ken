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
            title: Center(child: Text('TextAutocomplete Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupLabel(
                        _scaffoldKey, _formKey, ['regular autocomplete']),
                    SmeupTextAutocomplete(
                      _scaffoldKey,
                      _formKey,
                      label: 'description',
                      id: 'autocomplete1',
                      valueField: "value",
                      data: [
                        {
                          "code": "1",
                          "value": "description 1",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "2",
                          "value": "description 2",
                          "type": "",
                          "parameter": ""
                        }
                      ],
                      clientOnSelected: (option) {
                        SmeupUtilities.invokeScaffoldMessenger(context,
                            'selected code: ${option['code']}, value: ${option['value']}');
                      },
                    ),
                    SmeupLabel(_scaffoldKey, _formKey,
                        ['autocomplete with submit button']),
                    SmeupTextAutocomplete(
                      _scaffoldKey,
                      _formKey,
                      label: 'description',
                      id: 'autocomplete2',
                      valueField: "value",
                      data: [
                        {
                          "code": "1",
                          "value": "description 1",
                          "type": "",
                          "parameter": ""
                        },
                        {
                          "code": "2",
                          "value": "description 2",
                          "type": "",
                          "parameter": ""
                        }
                      ],
                      showSubmit: true,
                      submitLabel: "tap me",
                      clientOnSelected: (option) {
                        SmeupUtilities.invokeScaffoldMessenger(context,
                            'selected code: ${option['code']}, value: ${option['value']}');
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

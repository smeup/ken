import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_input_panel_field.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_inputpanel.dart';

class InputPanelScreen extends StatelessWidget {
  static const routeName = '/InputPanelScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Input Panel Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: _getInputPanelWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  SmeupInputPanel _getInputPanelWidget(BuildContext context) {
    return SmeupInputPanel(
      _scaffoldKey,
      _formKey,
      id: 'inputpanel',
      data: _getInputPanelFields(),
      onSubmit: (fields) {
        List<String> values =
            fields.map((e) => "code=${e.id} value=${e.value.code}").toList();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Fields $values")));
      },
    );
  }

  List<SmeupInputPanelField> _getInputPanelFields() {
    final List<SmeupInputPanelField> data = [];
    data.add(SmeupInputPanelField(
      id: "RAD",
      label: "Rilevato stato febbrile ?",
      component: SmeupInputPanelSupportedComp.Rad,
      value: SmeupInputPanelValue(),
    ));
    data.add(SmeupInputPanelField(
      id: "RAD",
      label: "Sintomi influenzali ?",
      component: SmeupInputPanelSupportedComp.Rad,
      value: SmeupInputPanelValue(),
    ));
    data.add(SmeupInputPanelField(
      id: "QRC",
      label: "QrCode",
      component: SmeupInputPanelSupportedComp.Bcd,
      value: SmeupInputPanelValue(code: "asdadsasfasfasdfasdfasdfasf"),
    ));
    final items = [
      {"code": "LANSTS", "descr": "Lanari Stefano"},
      {"code": "PASCAR", "descr": "Pasere Carina"}
    ];
    data.add(SmeupInputPanelField(
        id: "CMB",
        label: "Elenco collaboratori",
        value: new SmeupInputPanelValue(),
        items: items
            .map((item) =>
                SmeupInputPanelValue(code: item["code"], descr: item["descr"]))
            .toList(),
        component: SmeupInputPanelSupportedComp.Cmb));
    return data;
  }
}

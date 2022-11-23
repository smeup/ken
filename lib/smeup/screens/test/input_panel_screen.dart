import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_input_panel_value.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_inputpanel.dart';

import '../../services/ken_theme_configuration_service.dart';

class InputPanelScreen extends StatelessWidget {
  static const routeName = '/InputPanelScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Input Panel Screen')),
            actions: ShowCaseShared.getEmptyAction(),
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

  KenInputPanel _getInputPanelWidget(BuildContext context) {
    return KenInputPanel(
      _scaffoldKey,
      _formKey,
      id: 'inputpanel',
      data: _getInputPanelFields(),
      onSubmit: (fields) {
        List<String>? values =
            fields?.map((e) => "code=${e.id} value=${e.value.code}").toList();
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
      component: KenInputPanelSupportedComp.Rad,
      value: SmeupInputPanelValue(),
    ));
    data.add(SmeupInputPanelField(
      id: "RAD",
      label: "Sintomi influenzali ?",
      component: KenInputPanelSupportedComp.Rad,
      value: SmeupInputPanelValue(),
    ));
    data.add(SmeupInputPanelField(
      id: "QRC",
      label: "QrCode",
      component: KenInputPanelSupportedComp.Bcd,
      value: SmeupInputPanelValue(code: "asdadsasfasfasdfasdfasdfasf"),
    ));
    final items = [
      {"code": "LANSTS", "description": "Lanari Stefano"},
      {"code": "PASCAR", "description": "Pasere Carina"}
    ];
    data.add(SmeupInputPanelField(
        id: "CMB",
        label: "Elenco collaboratori",
        value: new SmeupInputPanelValue(),
        items: items
            .map((item) => SmeupInputPanelValue(
                code: item["code"], description: item["description"]))
            .toList(),
        component: KenInputPanelSupportedComp.Cmb));
    return data;
  }
}

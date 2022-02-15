import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_list_box.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ListBoxScreen extends StatelessWidget {
  static const routeName = '/ListBoxScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ListBox Screen')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                        'This widget is a list of boxes whose format is predetermined by a layout. It is also possible to decide the number of columns'),
                    SmeupListBox(
                        _scaffoldKey,
                        _formKey,
                        {
                          "rows": [
                            {
                              "code": "0001",
                              "description": "Description 1",
                              "info": "Information ford code 1",
                              "back": "R006G140B154"
                            },
                            {
                              "code": "0002",
                              "description": "Description 2",
                              "info": "Information for code 2",
                              "back": "R006G140B154"
                            },
                            {
                              "code": "0003",
                              "description": "Description 3",
                              "info": "Information for code 3",
                              "back": "R006G140B154"
                            }
                          ],
                          "columns": [
                            {"code": "code", "text": "codice", "IO": "O"},
                            {
                              "code": "description",
                              "text": "descrizione",
                              "IO": "O"
                            },
                            {"code": "info", "text": "informazioni", "IO": "H"},
                            {
                              "code": "back",
                              "text": "background color",
                              "IO": "H"
                            }
                          ]
                        },
                        height: 100,
                        listHeight: 300,
                        listType: SmeupListType.oriented,
                        fontSize: 16.0,
                        backColor: Colors.white,
                        showSelection: false,
                        selectedRow: 1,
                        id: 'listbox1', clientOnItemTap: (item) {
                      SmeupUtilities.invokeScaffoldMessenger(
                          context, 'item clicked: $item');
                    })
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

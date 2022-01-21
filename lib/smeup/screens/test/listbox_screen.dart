import 'package:flutter/material.dart';
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
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    Text('List box', textAlign: TextAlign.left),
                    SmeupListBox(
                        _scaffoldKey,
                        _formKey,
                        {
                          "rows": [
                            {"code": "a", "description": "b", "info": "boh1"},
                            {"code": "c", "description": "d", "info": "boh2"}
                          ],
                          "columns": [
                            {'code': 'code', 'text': 'codice', 'IO': "O"},
                            {
                              'code': 'description',
                              'text': 'descrizione',
                              'IO': "O"
                            },
                            {'code': 'info', 'text': 'informazioni', 'IO': "H"}
                          ]
                        },
                        height: 100,
                        listHeight: 200,
                        id: 'listbox1', clientOnItemTap: (item) {
                      SmeupUtilities.invokeScaffoldMessenger(
                          context, 'item clicked: $item');
                    }),
                    Text(
                        'List box ordered by description, selectable and pre selected',
                        textAlign: TextAlign.left),
                    SmeupListBox(
                      _scaffoldKey,
                      _formKey,
                      {
                        "rows": [
                          {"code": "a", "description": "d", "info": "boh1"},
                          {"code": "c", "description": "b", "info": "boh2"}
                        ],
                        "columns": [
                          {'code': 'code', 'text': 'codice', 'IO': "O"},
                          {
                            'code': 'description',
                            'text': 'descrizione',
                            'IO': "O"
                          },
                          {'code': 'info', 'text': 'informazioni', 'IO': "H"}
                        ]
                      },
                      id: 'listbox2',
                      height: 100,
                      listHeight: 200,
                      clientOnItemTap: (item) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'item clicked: $item');
                      },
                      defaultSort: 'description',
                      showSelection: true,
                      selectedRow: 1,
                    ),
                    Text('List box with colors', textAlign: TextAlign.left),
                    SmeupListBox(
                      _scaffoldKey,
                      _formKey,
                      {
                        "rows": [
                          {
                            "code": "a",
                            "description": "d",
                            "info": "boh1",
                            "back": "R255G255B000"
                          },
                          {
                            "code": "c",
                            "description": "b",
                            "info": "boh2",
                            "back": "R000G255B000"
                          }
                        ],
                        "columns": [
                          {'code': 'code', 'text': 'codice', 'IO': "O"},
                          {
                            'code': 'description',
                            'text': 'descrizione',
                            'IO': "O"
                          },
                          {'code': 'info', 'text': 'informazioni', 'IO': "H"},
                          {
                            'code': 'back',
                            'text': 'background color',
                            'IO': "H"
                          }
                        ]
                      },
                      id: 'listbox3',
                      clientOnItemTap: (item) {
                        SmeupUtilities.invokeScaffoldMessenger(
                            context, 'item clicked: $item');
                      },
                      fontColor: Colors.red,
                      backColor: Colors.yellow,
                      backgroundColName: "back",
                      height: 100,
                      listHeight: 200,
                    )
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

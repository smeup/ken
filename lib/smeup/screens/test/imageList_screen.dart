import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_image_list.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ImageListScreen extends StatelessWidget {
  static const routeName = '/ImageListScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ImageList')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Center(
                  child: Column(children: [
                ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                    'This widget is capable of showing images on one or more columns/rows'),
                SmeupImageList(
                  _scaffoldKey,
                  _formKey,
                  {
                    "rows": [
                      {
                        "code": "packages/ken/assets/images/IMG1.png",
                        "description": "1st Illustration",
                        "info": "boh1",
                        "isRemote": false,
                        "width": 200,
                        "height": 200
                      },
                      {
                        "code": "packages/ken/assets/images/IMG2.png",
                        "description": "2nd Illustration",
                        "info": "boh2",
                        "isRemote": false,
                        "width": 200,
                        "height": 200
                      },
                      {
                        "code": "packages/ken/assets/images/IMG3.png",
                        "description": "3rd Illustration",
                        "info": "boh3",
                        "isRemote": false,
                        "width": 200,
                        "height": 200
                      },
                      {
                        "code": "packages/ken/assets/images/IMG4.png",
                        "description": "4th Illustration",
                        "info": "boh3",
                        "isRemote": false,
                        "width": 200,
                        "height": 200
                      },
                      {
                        "code": "packages/ken/assets/images/IMG5.png",
                        "description": "5th Illustration",
                        "info": "boh2",
                        "isRemote": false,
                        "width": 200,
                        "height": 200
                      }
                    ],
                    "columns": [
                      {'code': 'code', 'text': 'codice', 'IO': "H"},
                      {'code': 'description', 'text': 'descrizione', 'IO': "O"},
                      {'code': 'info', 'text': 'informazioni', 'IO': "H"},
                      {'code': 'isRemote', 'text': 'remote image', 'IO': "H"},
                      {"code": "width", "text": "image width", "IO": "H"},
                      {"code": "height", "text": "image height", "IO": "H"}
                    ]
                  },
                  0,
                  1,
                  id: 'imageList1',
                  height: 330,
                  width: 450,
                  listHeight: 480,
                  clientOnItemTap: (Map item) {
                    SmeupUtilities.invokeScaffoldMessenger(
                        context, 'you clicked the ${item['description']}');
                  },
                )
              ])),
            ),
          ),
        ),
      ),
    );
  }
}

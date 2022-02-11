import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_image_list.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class ImageListScreen extends StatelessWidget {
  static const routeName = '/ImageListScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('ImageList Screen')),
          ),
          body: SingleChildScrollView(
            child: SmeupImageList(
              _scaffoldKey,
              _formKey,
              {
                "rows": [
                  {
                    "code":
                        "packages/ken/assets/images/image_list_blue_Tavola disegno 1.png",
                    "description": "first image",
                    "info": "boh1",
                    "isRemote": false
                  },
                  {
                    "code":
                        "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 2.png",
                    "description": "second image",
                    "info": "boh2",
                    "isRemote": false
                  },
                  {
                    "code":
                        "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 3.png",
                    "description": "third image",
                    "info": "boh3",
                    "isRemote": false
                  },
                  {
                    "code":
                        "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 4.png",
                    "description": "third image",
                    "info": "boh3",
                    "isRemote": false
                  },
                  {
                    "code":
                        "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 5.png",
                    "description": "second image",
                    "info": "boh2",
                    "isRemote": false
                  }
                ],
                "columns": [
                  {'code': 'code', 'text': 'codice', 'IO': "H"},
                  {'code': 'description', 'text': 'descrizione', 'IO': "O"},
                  {'code': 'info', 'text': 'informazioni', 'IO': "H"},
                  {'code': 'isRemote', 'text': 'remote image', 'IO': "H"}
                ]
              },
              0,
              2,
              id: 'imageList1',
              height: 350,
              width: 350,
              listHeight: deviceInfo.size.height,
              clientOnItemTap: (item) {
                SmeupUtilities.invokeScaffoldMessenger(
                    context, 'item clicked: $item');
              },
            ),
          ),
        ),
      ),
    );
  }
}

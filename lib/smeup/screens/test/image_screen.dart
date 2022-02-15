import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_image.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/ImageScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Image')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                        'Highly customizable, feature-packed image widget for Flutter'),
                    SmeupImage(_scaffoldKey, _formKey,
                        'packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 5.png',
                        id: 'img1', width: 300, height: 300, isRemote: false),
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

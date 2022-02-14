import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_image.dart';
import 'package:ken/smeup/widgets/smeup_label.dart';

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
            title: Center(child: Text('Image Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupLabel(_scaffoldKey, _formKey, ['Local image']),
                    SmeupImage(_scaffoldKey, _formKey,
                        'packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 5.png',
                        id: 'img1', width: 200, height: 200, isRemote: false),
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

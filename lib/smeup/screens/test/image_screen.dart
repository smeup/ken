import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_image.dart';

import '../../services/ken_theme_configuration_service.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/ImageScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
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
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                    child: Column(
                  children: [
                    ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                        'This widget is used to show a single image'),
                    KenImage(_scaffoldKey, _formKey,
                        'packages/ken/assets/images/IMG1.png',
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

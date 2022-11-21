import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_carousel.dart';

import '../../services/ken_theme_configuration_service.dart';

class CarouselScreen extends StatelessWidget {
  static const routeName = '/CarouselScreen';
  static const description =
      'Carousel component in Flutter. You can customize the description of the image';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Carousel')),
            actions: ShowCaseShared.getEmptyAction(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              //child: Padding(
              //padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(
                      _scaffoldKey, _formKey, description),
                  KenCarousel(
                      _scaffoldKey,
                      _formKey,
                      [
                        {
                          "imageFile": "packages/ken/assets/images/IMG1.png",
                          "text": "1st illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG2.png",
                          "text": "2nd illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG3.png",
                          "text": "3rd illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG4.png",
                          "text": "4th illustration"
                        },
                        {
                          "imageFile": "packages/ken/assets/images/IMG5.png",
                          "text": "5th illustration"
                        }
                      ],
                      height: 300,
                      autoPlay: false,
                      id: 'cau1'),
                ],
              )),
              //),
            ),
          ),
        ),
      ),
    );
  }
}

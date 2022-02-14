import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/smeup_carousel.dart';

class CarouselScreen extends StatelessWidget {
  static const routeName = '/CarouselScreen';
  static const description =
      'Carousel component in Flutter. You can customize the description of the image';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Carousel')),
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
                  SmeupCarousel(
                      _scaffoldKey,
                      _formKey,
                      [
                        {
                          "imageFile":
                              "packages/ken/assets/images/image_list_blue_Tavola disegno 1.png",
                          "text": "I am a reveille"
                        },
                        {
                          "imageFile":
                              "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 2.png",
                          "text": "I am a ball"
                        },
                        {
                          "imageFile":
                              "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 3.png",
                          "text": "I am a telephone"
                        },
                        {
                          "imageFile":
                              "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 4.png",
                          "text": "I am a fruit"
                        },
                        {
                          "imageFile":
                              "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 5.png",
                          "text": "I am a cherry"
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

import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_carousel.dart';

class CarouselScreen extends StatelessWidget {
  static const routeName = '/CarouselScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Carousel Screen')),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Column(
                  children: [
                    SmeupCarousel(
                        _scaffoldKey,
                        _formKey,
                        [
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_blue_Tavola disegno 1.png",
                            "text": "Descriptive text one"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 2.png",
                            "text": "Descriptive text  two"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 3.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 4.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_blue_Tavola disegno 1 copia 5.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1 copia.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1 copia 2.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1 copia 3.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1 copia 4.png",
                            "text": "Descriptive text  three"
                          },
                          {
                            "imageFile":
                                "packages/ken/assets/images/image_list_orange_Tavola disegno 1 copia 5.png",
                            "text": "Descriptive text  three"
                          }
                        ],
                        height: 300,
                        autoPlay: false,
                        id: 'cau1'),
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

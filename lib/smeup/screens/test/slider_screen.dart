import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_slider.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class SliderScreen extends StatelessWidget {
  static const routeName = '/SliderScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
      child: Builder(
        builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Slider Screen')),
              actions: ShowCaseShared.getEmptyAction(),
            ),
            body: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                              'A slider can be used to select from either a continuous or a discrete set of values'),
                          KenSlider(_scaffoldKey, _formKey,
                              id: 'sld1', value: 20, clientOnChange: (value) {
                            KenUtilities.invokeScaffoldMessenger(context,
                                "You have changed the slider to: $value");
                          })
                        ],
                      ),
                    )))),
      ),
    );
  }
}

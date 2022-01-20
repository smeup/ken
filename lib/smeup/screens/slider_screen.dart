import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/widgets/smeup_slider.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SliderScreen extends StatelessWidget {
  static const routeName = '/SliderScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmeupConfigurationService.getTheme(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Slider Screen')),
          ),
          body: SmeupSlider(_scaffoldKey, _formKey, id: 'sld1', value: 20,
              clientOnChange: (value) {
            SmeupUtilities.invokeScaffoldMessenger(
                context, "You have changed the slider to: $value");
          }),
        ),
      ),
    );
  }
}

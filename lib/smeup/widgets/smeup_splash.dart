import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';

class SmeupSplash extends StatelessWidget {
  final Color color;
  SmeupSplash({this.color = SmeupConfigurationService.defaultSplashColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

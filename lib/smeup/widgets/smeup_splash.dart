import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

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

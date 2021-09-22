import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'smeup_progress_indicator.dart';
import 'smeup_splash.dart';

class SmeupWait extends StatelessWidget {
  final Color splashColor;
  final Color loaderColor;

  SmeupWait(
      {this.splashColor = SmeupConfigurationService.defaultSplashColor,
      this.loaderColor = SmeupConfigurationService.defaultLoaderColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [SmeupSplash(), SmeupProgressIndicator(loaderColor)],
    );
  }
}

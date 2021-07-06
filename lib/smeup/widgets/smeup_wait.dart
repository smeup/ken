import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'smeup_progress_indicator.dart';
import 'smeup_splash.dart';

class SmeupWait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SmeupSplash(SmeupOptions.appSplashColor),
        SmeupProgressIndicator(SmeupOptions.loaderColor)
      ],
    );
  }
}

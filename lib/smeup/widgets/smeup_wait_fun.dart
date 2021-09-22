import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'smeup_progress_indicator.dart';
import 'smeup_splash.dart';

class SmeupWaitFun extends StatelessWidget {
  final Widget target;

  SmeupWaitFun(this.target);

  @override
  Widget build(BuildContext context) {
    var start = DateTime.now();

    return FutureBuilder<Widget>(
      future: _getWidget(3000, start),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              target,
              SmeupSplash(),
              SmeupProgressIndicator(
                  SmeupConfigurationService.defaultLoaderColor),
            ],
          );
        } else {
          return snapshot.data;
        }
      },
    );
  }

  Future<Widget> _getWidget(int timeout, DateTime start) {
    try {
      return Future(() {
        var diff = DateTime.now().difference(start);
        if (SmeupDataService.getDataFetch() == 0) {
          return target;
        } else {
          if (diff.inMilliseconds > timeout) {
            return target;
          } else {
            return Future.delayed(Duration(milliseconds: 100))
                .then((value) => _getWidget(timeout, start));
          }
        }
      });
    } catch (e) {}
    return Future(() {
      return target;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_wait_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'smeup_progress_indicator.dart';
import 'smeup_splash.dart';

// ignore: must_be_immutable
class SmeupWaitFun extends StatelessWidget {
  Widget target;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color? splashColor;
  Color? loaderColor;
  Color? circularTrackColor;

  SmeupWaitFun(this.scaffoldKey, this.formKey, this.target,
      {this.splashColor, this.loaderColor, this.circularTrackColor}) {
    SmeupWaitModel.setDefaults(this);
  }

  @override
  Widget build(BuildContext context) {
    var start = DateTime.now();

    return FutureBuilder<Widget>(
      key: Key('smeupWaitFun_${formKey.hashCode}'),
      future: _getWidget(3000, start),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              Container(
                color: SmeupConfigurationService.getTheme()!.splashColor,
              ),
              target,
              SmeupSplash(scaffoldKey, formKey,
                  color: splashColor,
                  id: 'SmeupSplash_${scaffoldKey.hashCode.toString()}'),
              SmeupProgressIndicator(scaffoldKey, formKey,
                  color: loaderColor,
                  circularTrackColor: circularTrackColor,
                  id: 'SmeupProgressIndicator_${scaffoldKey.hashCode.toString()}'),
            ],
          );
        } else {
          return snapshot.data!;
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

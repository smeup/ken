import 'package:ken/smeup/models/authentication_model.dart';
import 'package:ken/smeup/models/fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';

import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:package_info/package_info.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isInitialized = false;
  String initialFun = '';

  @override
  void initState() {
    initialFun = 'F(EXD;*JSN;) 2(;;app_home)';
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      SmeupConfigurationService.packageInfoModel = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder<void>(
          future: _configureServices(context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _getWait();
            } else {
              final smeupFun = SmeupFun(initialFun, null, null, context);
              return SmeupDynamicScreen(
                initialFun: smeupFun,
                backButtonVisible: false,
              );
            }
          }),
    );
  }

  Future<void> _configureServices(BuildContext context) async {
    if (!_isInitialized) {
      await SmeupConfigurationService.init(
        context,
        logLevel: LogType.error,
        authenticationModel: AuthenticationModel(managed: false),
      );

      _isInitialized = true;
    }
  }

  Widget _getWait() {
    return Stack(
      children: [
        Container(
          color: Color(0xff06899b),
        ),
        Center(
          child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Color(0xff06899b),
                backgroundColor: Color(0xff53b9cc),
              )),
        )
      ],
    );
  }
}

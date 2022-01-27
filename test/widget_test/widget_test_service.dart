import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/models/notifiers/smeup_error_notifier.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeupLocalizationDelegate.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:provider/provider.dart';

class WidgetTestService {
  static bool isInitialized = false;
  static initTests() async {
    if (isInitialized) return;
    isInitialized = true;
    TestWidgetsFlutterBinding.ensureInitialized();

    await SmeupConfigurationService.init(null);
    expect(SmeupConfigurationService.jsonsPath, 'assets/jsons');
  }

  static getDynamicScreen(String jsonFile) async {
    var smeupFun = SmeupFun('F(EXD;*JSN;) 2(;;$jsonFile)', null, null, null);
    expect(smeupFun.fun['fun']['service'], '*JSN');

    final res = await SmeupDataService.invoke(smeupFun);

    expect(res.succeded, true);

    final smeupDynamicScreen = MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: SmeupErrorNotifier(),
      ),
    ], child: SmeupDynamicScreen(initialFun: smeupFun));

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(localizationsDelegates: [
          SmeupLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ], home: smeupDynamicScreen));

    return testWidget;
  }
}

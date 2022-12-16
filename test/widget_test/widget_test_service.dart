import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/services/ken_configuration_service.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:json_theme/json_theme.dart';

class WidgetTestService {
  static bool isInitialized = false;
  static ThemeData? _theme;

  static initTests() async {
    if (isInitialized) return;
    isInitialized = true;
    TestWidgetsFlutterBinding.ensureInitialized();

    await setTheme('');

    await KenConfigurationService.init(null,
        jsonsPath: 'assets/jsons', theme: _theme);

    expect(
      KenConfigurationService.jsonsPath,
      'assets/jsons',
    );
  }

  static setTheme(String themeFile) async {
    try {
      if (themeFile.isNotEmpty) {
        String themeStr =
            await rootBundle.loadString('assets/jsons/themes/$themeFile');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson, validate: false);
        KenLogService.writeDebugMessage('Loaded $themeFile theme file');
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: KenLogType.error);
    } finally {
      if (_theme == null) {
        String themeStr =
            await rootBundle.loadString('assets/jsons/themes/smeup_theme.json');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson);
        // print(_theme);
      }
    }
  }

  // static getDynamicScreen(String jsonFile) async {
  //   var smeupFun = Fun('F(EXD;*JSN;) 2(;;$jsonFile)', null, null, null);
  //   expect(smeupFun.identifier.service, '*JSN');

  //   final res = await SmeupDataService.invoke(smeupFun);

  //   expect(res.succeded, true);

  //   final smeupDynamicScreen = MultiProvider(providers: [
  //     ChangeNotifierProvider.value(
  //       value: SmeupErrorNotifier(),
  //     ),
  //   ], child: SmeupDynamicScreen(initialFun: smeupFun));

  //   Widget testWidget = new MediaQuery(
  //       data: new MediaQueryData(),
  //       child: new MaterialApp(localizationsDelegates: [
  //         SmeupLocalizationDelegate(),
  //         GlobalMaterialLocalizations.delegate,
  //         GlobalWidgetsLocalizations.delegate,
  //         GlobalCupertinoLocalizations.delegate,
  //         DefaultCupertinoLocalizations.delegate
  //       ], home: smeupDynamicScreen));

  //   return testWidget;
  // }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ken/smeup/managers/ken_configuration_manager.dart';
import 'package:json_theme/json_theme.dart';

class WidgetTestService {
  static bool isInitialized = false;
  static ThemeData? _theme;
  static GlobalKey<ScaffoldState> formKey = GlobalKey<ScaffoldState>();
  static Key sectionKey = GlobalKey<FormState>();

  static initTests() async {
    if (isInitialized) return;
    isInitialized = true;
    TestWidgetsFlutterBinding.ensureInitialized();

    await setTheme('');

    await KenConfigurationManager.init(null,
        jsonsPath: 'assets/jsons', theme: _theme);

    expect(
      KenConfigurationManager.jsonsPath,
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
        //debugPrint('Loaded $themeFile theme file');
      }
    } catch (e) {
      debugPrint('Error in getAppStructure: $e');
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
}

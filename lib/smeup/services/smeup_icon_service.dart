import 'package:flutter/material.dart';

import '../models/fun.dart';
import 'smeup_data_service.dart';

class SmeupIconService {
  static Map<String, dynamic>? icons;

  static init() async {
    var smeupFun = Fun(
        'F(EXD;*JSN;) 2(MB;SCP_SCH;icons) SERVER(source(packages/ken/assets/jsons))',
        null,
        null,
        null);

    final res = await SmeupDataService.invoke(smeupFun);
    if (res.succeded)
      icons = res.result.data;
    else
      icons = {};
  }

  static IconData? getIconData(dynamic searchCode,
      {fontFamily = 'MaterialIcons'}) {
    String? key = getIconKey(searchCode);
    if (key == null) return null;
    int iconData = int.tryParse(icons![key]['hex']) ?? 0;
    if (iconData == 0) return null;
    return IconData(iconData, fontFamily: fontFamily);
  }

  static String? getIconKey(dynamic searchCode) {
    String searchCodeStr = searchCode.toString();
    if (searchCodeStr.isEmpty) {
      return null;
    }

    if (searchCode is int) {
      // search by hex code
      var element = icons!.entries.cast<dynamic>().firstWhere((element) {
        return element.value['hex'] == searchCode;
      }, orElse: () => null);

      if (element != null) {
        return (element as MapEntry<String, dynamic>).key;
      }
    } else if (searchCodeStr.contains(';')) {
      // search by key
      String key = searchCodeStr.toString().replaceAll(';', '_');
      if (icons!.containsKey(key)) {
        return key;
      }
    } else if (searchCodeStr.startsWith('0x')) {
      // search by hex code (as string)
      int searchCodeInt = int.tryParse(searchCode) ?? 0;
      if (searchCodeInt == 0) return null;
      var element = icons!.entries.cast<dynamic>().firstWhere((element) {
        return element.value['hex'] == searchCodeInt;
      }, orElse: () => null);

      if (element != null) {
        return (element as MapEntry<String, dynamic>).key;
      }
    } else {
      // search by name
      var element = icons!.entries.cast<dynamic>().firstWhere((element) {
        return element.value['name'] == searchCodeStr;
      }, orElse: () => null);

      if (element != null) {
        return (element as MapEntry<String, dynamic>).key;
      }
    }

    return null;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupLocalizationService {
  SmeupLocalizationService(this.locale);
  final _nagerUrl = 'https://date.nager.at/api/v3/publicholidays';

  final Locale locale;

  static SmeupLocalizationService of(BuildContext context) {
    return Localizations.of<SmeupLocalizationService>(
        context, SmeupLocalizationService);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'confirm': 'CONFIRM',
      'cancel': 'CANCEL',
      'areYouSureDelete': 'Are you sure you wish to delete this item?',
      'delete': 'DELETE',
      'elementDeleted': 'The item has been deleted',
      'dataNotAvailable': 'Data not available',
      'settings': 'SETTINGS',
      'month': 'Month',
      '2weeks': '2 Weeks',
      'week': 'Week'
    },
    'it': {
      'confirm': 'CONFERMA',
      'cancel': 'ANNULLA',
      'areYouSureDelete': 'Sicuro di vole eliminare questo elemento?',
      'delete': 'ELIMINA',
      'elementDeleted': 'L\'elemento è stato eliminato',
      'dataNotAvailable': 'Dati non disponibili',
      'settings': 'IMPOSTAZIONI',
      'month': 'Mese',
      '2weeks': '2 Settimane',
      'week': 'Settimana'
    },
    'fr': {
      'confirm': 'CONFIRMATION',
      'cancel': 'ANNULER',
      'areYouSureDelete': 'Est-il sûr de vouloir supprimer cet élément?',
      'delete': 'SUPPRIMER',
      'elementDeleted': 'L\'élément a été supprimé',
      'dataNotAvailable': 'Données non disponibles',
      'settings': 'PARAMÈTRES',
      'month': 'Mois',
      '2weeks': '2 Semaines',
      'week': 'Semaine'
    },
  };

  String getLocalString(stringCode) {
    var localString = _localizedValues[locale.languageCode][stringCode];

    if (localString != null) {
      return localString;
    } else {
      return stringCode;
    }
  }

  Future<Map<DateTime, List>> getHolidays(int year, String country) async {
    var holidays = Map<DateTime, List>();
    Function addHoliday = (DateTime date, String description) {
      List holidayList;

      DateTime key = DateTime(date.year, date.month, date.day);

      if (holidays[key] == null)
        holidayList = List<String>.empty(growable: true);
      else
        holidayList = holidays[key];

      holidayList.add(description);
      holidays[key] = holidayList;
    };

    final listPublic = await _getPublicHolidaysFromNager(year, country);
    listPublic.forEach((holiday) {
      DateTime date = DateTime.tryParse(holiday['date']);
      String description = holiday['localName'];
      addHoliday(date, description);
    });

    final listCustom = await _getCustomHolidays();
    listCustom.forEach((holiday) {
      DateTime date = DateTime.tryParse(holiday['date']);
      String description = holiday['description'];
      addHoliday(date, description);
    });

    //print(listPublic);
    //print(listCustom);
    return holidays;
  }

  Future<List> _getPublicHolidaysFromNager(int year, String country) async {
    var list = List.empty(growable: true);

    Dio dio;
    dio = Dio();
    Response response;

    try {
      response = await dio.get('$_nagerUrl/$year/$country');
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          '_getPublicHolidaysFromNager dio error: $e (${e.message != null ? e.message : ''})',
          logType: LogType.error);
      if (e.response != null) {
        response = e.response;
      } else {
        response = Response(
            data: 'Unkwnown Error',
            statusCode: HttpStatus.badRequest,
            requestOptions: null);
      }
    } finally {
      dio.close();
      dio = null;
    }

    bool isValid = SmeupDataService.isValid(response.statusCode);
    if (isValid) {
      list = response.data;
      SmeupLogService.writeDebugMessage(
          'Loaded public holidays from Nager.date website');
    } else {
      SmeupLogService.writeDebugMessage(
          'error loding public holidays from Nager.date website',
          logType: LogType.error);
    }

    return list;
  }

  static Future<List> _getCustomHolidays() async {
    var custom = List.empty(growable: true);
    String jsonFilePath =
        '${SmeupConfigurationService.jsonsPath}/custom_holidays.json';

    try {
      String jsonString = await rootBundle.loadString(jsonFilePath);

      jsonString = SmeupUtilities.replaceDictionaryPlaceHolders(jsonString);

      custom = jsonDecode(jsonString);

      SmeupLogService.writeDebugMessage(
          'Loaded custom holidays from $jsonFilePath file');
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          '_getCustomHolidays error: $e (${e.message != null ? e.message : ''})',
          logType: LogType.error);
      SmeupLogService.writeDebugMessage(
          'error loding custom holidays from $jsonFilePath file',
          logType: LogType.error);
    }

    return custom;
  }
}

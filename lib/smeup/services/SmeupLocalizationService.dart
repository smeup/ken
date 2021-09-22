import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

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
    },
    'it': {
      'confirm': 'CONFERMA',
      'cancel': 'ANNULLA',
      'areYouSureDelete': 'Sicuro di vole eliminare questo elemento?',
      'delete': 'ELIMINA',
      'elementDeleted': 'L\'elemento è stato eliminato',
      'dataNotAvailable': 'Dati non disponibili',
    },
    'fr': {
      'confirm': 'CONFIRMATION',
      'cancel': 'ANNULER',
      'areYouSureDelete': 'Est-il sûr de vouloir supprimer cet élément?',
      'delete': 'SUPPRIMER',
      'elementDeleted': 'L\'élément a été supprimé',
      'dataNotAvailable': 'Données non disponibles',
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

    final listPublic = await _getPublicHolidaysFromNager(year, country);
    final listCustom = _getCustomHolidays();

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
    }

    bool isValid = SmeupDataService.isValid(response.statusCode);
    if (isValid) {
      list = response.data;
    }

    return list;
  }

  static Map<DateTime, List> _getCustomHolidays() {
    var custom = Map<DateTime, List>();

    return custom;
  }
}

import 'package:flutter/material.dart';

class KenLocalizationManager {
  KenLocalizationManager(this.locale);

  final Locale locale;

  static KenLocalizationManager? of(BuildContext context) {
    return Localizations.of<KenLocalizationManager>(
        context, KenLocalizationManager);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
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
    var localString = _localizedValues[locale.languageCode]![stringCode];

    if (localString != null) {
      return localString;
    } else {
      return stringCode;
    }
  }
}

import 'package:flutter/material.dart';

class SmeupLocalizationService {
  SmeupLocalizationService(this.locale);

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
      'elementDeleted': 'The item has been deleted'
    },
    'it': {
      'confirm': 'CONFERMA',
      'cancel': 'ANNULLA',
      'areYouSureDelete': 'Sicuro di vole eliminare questo elemento?',
      'delete': 'ELIMINA',
      'elementDeleted': 'L\'elemento è stato eliminato'
    },
    'fr': {
      'confirm': 'CONFIRMATION',
      'cancel': 'ANNULER',
      'areYouSureDelete': 'Est-il sûr de vouloir supprimer cet élément?',
      'delete': 'SUPPRIMER',
      'elementDeleted': 'L\'élément a été supprimé'
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
}

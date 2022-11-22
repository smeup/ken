import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ken_localization_service.dart';

class KenLocalizationDelegate
    extends LocalizationsDelegate<KenLocalizationService> {
  const KenLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'it', 'fr'].contains(locale.languageCode);

  @override
  Future<KenLocalizationService> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<KenLocalizationService>(
        KenLocalizationService(locale));
  }

  @override
  bool shouldReload(KenLocalizationDelegate old) => false;
}

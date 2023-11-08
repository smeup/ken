import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ken_localization_manager.dart';

class KenLocalizationDelegate
    extends LocalizationsDelegate<KenLocalizationManager> {
  const KenLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'it', 'fr'].contains(locale.languageCode);

  @override
  Future<KenLocalizationManager> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<KenLocalizationManager>(
        KenLocalizationManager(locale));
  }

  @override
  bool shouldReload(KenLocalizationDelegate old) => false;
}

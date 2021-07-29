import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'SmeupLocalizationService.dart';

class SmeupLocalizationDelegate
    extends LocalizationsDelegate<SmeupLocalizationService> {
  const SmeupLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'it', 'fr'].contains(locale.languageCode);

  @override
  Future<SmeupLocalizationService> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<SmeupLocalizationService>(
        SmeupLocalizationService(locale));
  }

  @override
  bool shouldReload(SmeupLocalizationDelegate old) => false;
}
